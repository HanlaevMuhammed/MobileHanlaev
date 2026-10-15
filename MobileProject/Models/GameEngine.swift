//
//  GameEngine.swift
//  MobileProject
//

import Combine
import CoreGraphics
import Foundation

enum GameState {
    case idle
    case running
    case finished
}

final class GameEngine: ObservableObject {
    @Published private(set) var bugs: [Bug] = []
    @Published private(set) var score: Int = 0
    @Published private(set) var hits: Int = 0
    @Published private(set) var misses: Int = 0
    @Published private(set) var timeRemaining: Double = 0
    @Published private(set) var state: GameState = .idle

    private let settings: GameSettings
    private var timer: Timer?
    private var lastTickDate = Date()
    private var spawnAccumulator: Double = 0

    /// Points lost on a miss; score is clamped at zero rather than allowed to go negative,
    /// since the UI only ever shows a plain, non-negative "Очки" counter.
    private let missPenalty = 5

    init(settings: GameSettings) {
        self.settings = settings
    }

    deinit {
        timer?.invalidate()
    }

    // MARK: - Lifecycle

    /// Always begins a brand-new round using the current GameSettings values, regardless of the
    /// previous state. Calling reset() immediately beforehand (as GameResultView's "Play again"
    /// button does) is therefore harmless but redundant — start() already resets internally.
    func start() {
        guard state != .running else { return }
        reset()
        state = .running
        lastTickDate = Date()
        spawnInitialBugs()

        timer?.invalidate()
        let newTimer = Timer(timeInterval: 1.0 / 60.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
        // Timer.scheduledTimer only fires in the run loop's .default mode, which UIKit suspends
        // while a touch is being tracked (e.g. exactly while the tap gesture on a bug is
        // recognized). tick() measures real elapsed wall-clock time, so a stalled timer resumes
        // with a large dt and can drain timeRemaining to zero in one shot — ending the round the
        // instant the user taps something. Adding it under .common instead keeps it firing during
        // gesture tracking, scrolling, etc.
        RunLoop.main.add(newTimer, forMode: .common)
        timer = newTimer
    }

    /// Pauses the round without clearing score/hits/misses, so the user can resume with start().
    func stop() {
        timer?.invalidate()
        timer = nil
        if state == .running {
            state = .idle
        }
    }

    func reset() {
        timer?.invalidate()
        timer = nil
        bugs = []
        score = 0
        hits = 0
        misses = 0
        timeRemaining = settings.roundDuration
        spawnAccumulator = 0
        state = .idle
    }

    // MARK: - Input

    func hit(bug: Bug) {
        guard state == .running else { return }
        guard let index = bugs.firstIndex(where: { $0.id == bug.id }) else { return }
        bugs.remove(at: index)
        hits += 1
        score += bug.points
    }

    func miss() {
        guard state == .running else { return }
        misses += 1
        score = max(0, score - missPenalty)
    }

    // MARK: - Game loop

    private func tick() {
        guard state == .running else { return }

        let now = Date()
        // Clamped as defense-in-depth against any stall long enough to produce a large dt (e.g. a
        // debugger breakpoint, or the app briefly backgrounded) — without this, a single stalled
        // tick could drain timeRemaining to zero outright instead of just taking a few ticks to
        // catch up.
        let dt = min(now.timeIntervalSince(lastTickDate), 0.25)
        lastTickDate = now

        move(by: dt)
        spawn(dt: dt)

        timeRemaining -= dt
        if timeRemaining <= 0 {
            timeRemaining = 0
            finish()
        }
    }

    private func move(by dt: TimeInterval) {
        guard dt > 0 else { return }
        let speedScale = CGFloat(settings.gameSpeed)
        let dtF = CGFloat(dt)

        bugs = bugs.map { bug in
            var bug = bug
            var newX = bug.position.x + bug.velocity.dx * speedScale * dtF
            var newY = bug.position.y + bug.velocity.dy * speedScale * dtF
            var vx = bug.velocity.dx
            var vy = bug.velocity.dy
            let half = bug.size / 2

            if newX - half < 0 {
                newX = half
                vx = abs(vx)
            } else if newX + half > 1 {
                newX = 1 - half
                vx = -abs(vx)
            }
            if newY - half < 0 {
                newY = half
                vy = abs(vy)
            } else if newY + half > 1 {
                newY = 1 - half
                vy = -abs(vy)
            }

            bug.position = CGPoint(x: newX, y: newY)
            bug.velocity = CGVector(dx: vx, dy: vy)
            return bug
        }
    }

    /// New-bug cadence is tied to GameSettings.bonusInterval (the "Интервал появления бонусов"
    /// slider in Settings): this stage treats every bug as the scoring target, so bonusInterval
    /// doubles as "how often another bug appears." maxCockroaches remains the hard population cap.
    private func spawn(dt: TimeInterval) {
        guard bugs.count < settings.maxCockroaches else { return }
        spawnAccumulator += dt
        guard spawnAccumulator >= settings.bonusInterval else { return }
        spawnAccumulator = 0
        bugs.append(makeRandomBug())
    }

    private func spawnInitialBugs() {
        let initialCount = min(3, settings.maxCockroaches)
        for _ in 0..<initialCount {
            bugs.append(makeRandomBug())
        }
    }

    private func finish() {
        timer?.invalidate()
        timer = nil
        state = .finished
    }

    // MARK: - Spawning helpers

    private func makeRandomBug() -> Bug {
        let type = weightedRandomType()
        let half = type.size / 2
        let position = CGPoint(
            x: CGFloat.random(in: half...(1 - half)),
            y: CGFloat.random(in: half...(1 - half))
        )
        let angle = CGFloat.random(in: 0..<(2 * .pi))
        let baseSpeed: CGFloat = 0.15 // logical units/sec at speedMultiplier 1.0
        let speed = baseSpeed * CGFloat(type.speedMultiplier)
        let velocity = CGVector(dx: cos(angle) * speed, dy: sin(angle) * speed)
        return Bug(position: position, velocity: velocity, size: type.size, type: type)
    }

    private func weightedRandomType() -> BugType {
        let total = BugType.allCases.reduce(0) { $0 + $1.spawnWeight }
        var roll = Double.random(in: 0..<total)
        for type in BugType.allCases {
            if roll < type.spawnWeight {
                return type
            }
            roll -= type.spawnWeight
        }
        return .common
    }
}

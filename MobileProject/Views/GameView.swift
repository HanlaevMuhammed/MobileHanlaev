//
//  GameView.swift
//  MobileProject
//

import SwiftUI

struct GameView: View {
    @StateObject private var engine: GameEngine

    init(settings: GameSettings) {
        _engine = StateObject(wrappedValue: GameEngine(settings: settings))
    }

    var body: some View {
        VStack(spacing: 16) {
            statsBar
            field
            controlButton
        }
        .padding()
        .navigationTitle(Strings.gameMenuTitle)
        .sheet(isPresented: isShowingResult) {
            GameResultView(engine: engine)
        }
    }

    /// Presentation is driven entirely by engine.state rather than a separate @State flag, so the
    /// sheet always reflects the true game state. If the sheet is swiped away while state is still
    /// .finished (i.e. no button was tapped), we reset to .idle ourselves. If it's being dismissed
    /// *because* a button already moved state to .running or .idle, we must not reset again here —
    /// that would clobber a freshly started "Play again" round — hence the state == .finished guard.
    private var isShowingResult: Binding<Bool> {
        Binding(
            get: { engine.state == .finished },
            set: { isPresented in
                if !isPresented && engine.state == .finished {
                    engine.reset()
                }
            }
        )
    }

    // MARK: - Stats bar

    private var statsBar: some View {
        HStack {
            statItem(title: Strings.gameScoreLabel, value: "\(engine.score)")
            Spacer()
            statItem(title: Strings.gameHitsLabel, value: "\(engine.hits)")
            Spacer()
            statItem(title: Strings.gameMissesLabel, value: "\(engine.misses)")
            Spacer()
            Text(Strings.gameTimeValue(engine.timeRemaining))
                .font(.subheadline)
                .monospacedDigit()
        }
    }

    private func statItem(title: String, value: String) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.title3.bold())
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Field

    /// The background carries its own low-priority tap gesture for misses; each bug carries its
    /// own tap gesture for hits. SwiftUI hit-tests front-to-back, so a tap landing inside a bug's
    /// (smaller) frame is captured by that bug's own gesture, and only taps that land nowhere on
    /// top of a bug fall through to the background underneath — no extra disambiguation needed.
    private var field: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Color(.secondarySystemBackground)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        engine.miss()
                    }

                ForEach(engine.bugs) { bug in
                    bugView(for: bug, in: geometry.size)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func bugView(for bug: Bug, in fieldSize: CGSize) -> some View {
        let pixelSize = max(32, bug.size * fieldSize.width)
        return Image(bug.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: pixelSize, height: pixelSize)
            .position(
                x: bug.position.x * fieldSize.width,
                y: bug.position.y * fieldSize.height
            )
            .onTapGesture {
                engine.hit(bug: bug)
            }
    }

    // MARK: - Control button

    private var controlButton: some View {
        Button {
            if engine.state == .running {
                engine.stop()
            } else {
                engine.start()
            }
        } label: {
            Text(engine.state == .running ? Strings.gameStopButton : Strings.gameStartButton)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    NavigationStack {
        GameView(settings: GameSettings())
    }
}

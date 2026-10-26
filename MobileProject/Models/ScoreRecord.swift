//
//  ScoreRecord.swift
//  MobileProject
//
//  The assignment specifies "Room" (Android's Jetpack persistence library) for this stage, but
//  Room is Android-only and has no iOS build or port. SwiftData is Apple's modern, declarative,
//  type-safe persistence framework and fills the same architectural role in this app:
//    - Room's @Entity class          <-> SwiftData's @Model class (ScoreRecord, below)
//    - Room's generated DAOs         <-> SwiftData's @Query property wrapper (compile-time-safe,
//                                        no hand-written SQL)
//    - Room's Flow/LiveData DAO      <-> @Query automatically re-runs and updates any SwiftUI
//      results driving Compose re-renders   view that reads it whenever the store changes
//    - Room's RoomDatabase            <-> SwiftData's ModelContainer (see MobileProjectApp.swift)
//  Both are ultimately backed by SQLite on disk, so the substitution preserves the same storage
//  model the assignment describes, just through Apple's native equivalent instead of a
//  Android-only third-party library.
//

import Foundation
import SwiftData

@Model
final class ScoreRecord {
    var playerName: String
    var score: Int
    var hits: Int
    var misses: Int
    var accuracy: Double        // 0...100
    var difficulty: Int         // snapshot of GameSettings.maxCockroaches when the round finished
    var gameSpeed: Double       // snapshot of GameSettings.gameSpeed when the round finished
    var roundDuration: Double   // snapshot of GameSettings.roundDuration when the round finished
    var datePlayed: Date

    // No @Attribute(.unique) here: the same player legitimately plays — and sets new records —
    // many times, so duplicate (playerName, score, ...) combinations are expected, not an error.
    init(
        playerName: String,
        score: Int,
        hits: Int,
        misses: Int,
        accuracy: Double,
        difficulty: Int,
        gameSpeed: Double,
        roundDuration: Double,
        datePlayed: Date = .now
    ) {
        self.playerName = playerName
        self.score = score
        self.hits = hits
        self.misses = misses
        self.accuracy = accuracy
        self.difficulty = difficulty
        self.gameSpeed = gameSpeed
        self.roundDuration = roundDuration
        self.datePlayed = datePlayed
    }
}

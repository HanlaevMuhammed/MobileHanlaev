//
//  GameSettings.swift
//  MobileProject
//
//  Kept as a plain ObservableObject (rather than local to a single view's
//  @State) so it can later be lifted to the app level and injected via
//  .environmentObject once the game screen needs to read these values,
//  without changing how SettingsView declares or binds to them.
//

import Combine
import Foundation

final class GameSettings: ObservableObject {
    @Published var gameSpeed: Double = 1.0
    @Published var maxCockroaches: Int = 10
    @Published var bonusInterval: Double = 5.0
    @Published var roundDuration: Double = 60.0
}

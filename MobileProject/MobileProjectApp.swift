//
//  MobileProjectApp.swift
//  MobileProject
//
//  Created by Мухаммед Ханлаев on 14.09.2026.
//

import SwiftData
import SwiftUI

@main
struct MobileProjectApp: App {
    @StateObject private var settings = GameSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
        // Creates the on-disk SQLite-backed store for ScoreRecord and makes it reachable from any
        // view in the hierarchy via @Environment(\.modelContext), the same way Room's database
        // instance is normally handed to every screen that needs it.
        .modelContainer(for: ScoreRecord.self)
    }
}

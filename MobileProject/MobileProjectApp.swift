//
//  MobileProjectApp.swift
//  MobileProject
//
//  Created by Мухаммед Ханлаев on 14.09.2026.
//

import SwiftUI

@main
struct MobileProjectApp: App {
    @StateObject private var settings = GameSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}

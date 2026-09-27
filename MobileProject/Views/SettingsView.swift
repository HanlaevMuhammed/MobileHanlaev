//
//  SettingsView.swift
//  MobileProject
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var settings = GameSettings()

    var body: some View {
        Form {
            Section(Strings.settingsSectionTitle) {
                speedRow
                maxCockroachesRow
                bonusIntervalRow
                roundDurationRow
            }
        }
        .navigationTitle(Strings.settingsTabTitle)
    }

    // MARK: - Rows

    private var speedRow: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.speedValue(settings.gameSpeed))
            Slider(value: $settings.gameSpeed, in: 0.5...3.0, step: 0.1) {
                Text(Strings.speedLabel)
            }
        }
    }

    private var maxCockroachesRow: some View {
        Stepper(value: $settings.maxCockroaches, in: 1...30) {
            Text(Strings.maxCockroachesValue(settings.maxCockroaches))
        }
    }

    private var bonusIntervalRow: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.bonusIntervalValue(settings.bonusInterval))
            Slider(value: $settings.bonusInterval, in: 1...30, step: 0.5) {
                Text(Strings.bonusIntervalLabel)
            }
        }
    }

    private var roundDurationRow: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.roundDurationValue(settings.roundDuration))
            Slider(value: $settings.roundDuration, in: 30...300, step: 10) {
                Text(Strings.roundDurationLabel)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}

//
//  ContentView.swift
//  MobileProject
//
//  Created by Мухаммед Ханлаев on 14.09.2026.
//

import SwiftData
import SwiftUI

/// The native TabView's built-in bottom bar only supports tap-to-switch, not swipe-to-switch, so
/// this app drives navigation from a single horizontally-paging TabView(.page) instead, with a
/// custom bottom bar (below) that mirrors the native bar's look and both reflects and sets
/// `selectedTab`. Each case is a stable, explicit identity (not a raw Int index), which keeps the
/// TabView's `.tag` values self-documenting at every call site.
enum AppTab: Int, CaseIterable, Identifiable {
    case game
    case records
    case rules
    case authors
    case settings
    case registration

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .game: return Strings.gameTabTitle
        case .records: return Strings.recordsTabTitle
        case .rules: return Strings.rulesTabTitle
        case .authors: return Strings.authorsTabTitle
        case .settings: return Strings.settingsTabTitle
        case .registration: return Strings.registrationTabTitle
        }
    }

    var systemImage: String {
        switch self {
        case .game: return "ladybug.fill"
        case .records: return "trophy.fill"
        case .rules: return "doc.richtext"
        case .authors: return "person.2"
        case .settings: return "gearshape"
        case .registration: return "person.crop.circle"
        }
    }
}

struct ContentView: View {
    @EnvironmentObject private var settings: GameSettings
    @State private var selectedTab: AppTab = .game

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                GameView(settings: settings)
            }
            .tag(AppTab.game)

            NavigationStack {
                RecordsView()
            }
            .tag(AppTab.records)

            NavigationStack {
                RulesView()
            }
            .tag(AppTab.rules)

            NavigationStack {
                AuthorsView()
            }
            .tag(AppTab.authors)

            NavigationStack {
                SettingsView()
            }
            .tag(AppTab.settings)

            NavigationStack {
                RegistrationView()
            }
            .tag(AppTab.registration)
        }
        // .page style is backed by a horizontally-paging UIScrollView, so it already supports a
        // finger swipe on device and a trackpad/mouse drag in the Simulator out of the box — the
        // same gesture a vertical ScrollView inside a page (e.g. RegistrationView) never competes
        // with, since the two scroll axes are perpendicular and resolved independently by the
        // gesture system. indexDisplayMode: .never hides the built-in page dots, since the custom
        // bottom bar below already shows which tab is selected.
        .tabViewStyle(.page(indexDisplayMode: .never))
        .safeAreaInset(edge: .bottom) {
            TabBar(selectedTab: $selectedTab)
        }
    }
}

/// Mirrors the native tab bar's look (SF Symbol + caption title, translucent material background)
/// while remaining a plain view the page TabView above can sit behind — this is what makes
/// tap-to-switch keep working alongside swipe-to-switch.
private struct TabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.systemImage)
                            .font(.system(size: 21))
                        Text(tab.title)
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(selectedTab == tab ? Color.accentColor : Color.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(.bar)
    }
}

#Preview {
    ContentView()
        .environmentObject(GameSettings())
        .modelContainer(for: ScoreRecord.self, inMemory: true)
}

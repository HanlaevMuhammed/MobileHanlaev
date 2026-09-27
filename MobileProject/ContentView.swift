//
//  ContentView.swift
//  MobileProject
//
//  Created by Мухаммед Ханлаев on 14.09.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab(Strings.registrationTabTitle, systemImage: "person.crop.circle") {
                NavigationStack {
                    RegistrationView()
                }
            }

            Tab(Strings.rulesTabTitle, systemImage: "doc.richtext") {
                NavigationStack {
                    RulesView()
                }
            }

            Tab(Strings.authorsTabTitle, systemImage: "person.2") {
                NavigationStack {
                    AuthorsView()
                }
            }

            Tab(Strings.settingsTabTitle, systemImage: "gearshape") {
                NavigationStack {
                    SettingsView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

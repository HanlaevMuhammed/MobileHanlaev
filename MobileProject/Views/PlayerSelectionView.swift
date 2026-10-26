//
//  PlayerSelectionView.swift
//  MobileProject
//

import SwiftData
import SwiftUI

struct PlayerSelectionView: View {
    @Environment(\.dismiss) private var dismiss

    // A plain string is all the "currently playing" state needs, and @AppStorage persists it
    // across launches for free — no SwiftData model required just to remember one selection.
    @AppStorage("selectedPlayerName") private var selectedPlayerName: String = ""

    // Reusing ScoreRecord as the source of "previously created players": every past round already
    // names its player, so a distinct list of playerName values doubles as the player roster
    // without a second model/table to keep in sync.
    @Query(sort: \ScoreRecord.datePlayed, order: .reverse) private var records: [ScoreRecord]

    @State private var isShowingRegistration = false

    private var playerNames: [String] {
        var seen = Set<String>()
        var ordered: [String] = []
        for record in records where !seen.contains(record.playerName) {
            seen.insert(record.playerName)
            ordered.append(record.playerName)
        }
        return ordered
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        isShowingRegistration = true
                    } label: {
                        Label(Strings.playerSelectionNew, systemImage: "person.badge.plus")
                    }
                }

                if !playerNames.isEmpty {
                    Section {
                        ForEach(playerNames, id: \.self) { name in
                            Button {
                                selectedPlayerName = name
                                dismiss()
                            } label: {
                                HStack {
                                    Text(name)
                                        .foregroundStyle(.primary)
                                    Spacer()
                                    if name == selectedPlayerName {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.tint)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(Strings.playerSelectionTitle)
            .sheet(isPresented: $isShowingRegistration) {
                NavigationStack {
                    RegistrationView()
                }
            }
            // RegistrationView (presented above) writes the chosen name to the same AppStorage
            // key on successful registration. Watching for that change here lets a brand-new
            // player flow straight back out to the game, instead of leaving two sheets stacked.
            .onChange(of: selectedPlayerName) { _, newValue in
                if !newValue.isEmpty {
                    isShowingRegistration = false
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    PlayerSelectionView()
        .modelContainer(for: ScoreRecord.self, inMemory: true)
}

//
//  RecordsView.swift
//  MobileProject
//

import SwiftData
import SwiftUI

private enum RecordsSortOption: String, CaseIterable, Identifiable {
    case score
    case date

    var id: String { rawValue }

    var title: String {
        switch self {
        case .score: return Strings.recordsSortByScore
        case .date: return Strings.recordsSortByDate
        }
    }
}

struct RecordsView: View {
    // @Query reads straight from the SwiftData store set up by .modelContainer in
    // MobileProjectApp.swift: it re-runs automatically and republishes `records` whenever a
    // ScoreRecord is inserted (e.g. right after a round finishes in GameView) or deleted anywhere
    // in the app, so this view never needs to manually refetch — the same role Room's
    // Flow-returning DAO plays for a Composable that collects it.
    @Query(sort: \ScoreRecord.score, order: .reverse) private var records: [ScoreRecord]

    @State private var sortOption: RecordsSortOption = .score
    @State private var selectedPlayer: String?

    private var playerNames: [String] {
        var seen = Set<String>()
        var ordered: [String] = []
        for record in records where !seen.contains(record.playerName) {
            seen.insert(record.playerName)
            ordered.append(record.playerName)
        }
        return ordered.sorted()
    }

    private var displayedRecords: [ScoreRecord] {
        var result = records
        if let selectedPlayer {
            result = result.filter { $0.playerName == selectedPlayer }
        }
        switch sortOption {
        case .score:
            result.sort { $0.score > $1.score }
        case .date:
            result.sort { $0.datePlayed > $1.datePlayed }
        }
        return result
    }

    var body: some View {
        Group {
            if records.isEmpty {
                ContentUnavailableView(Strings.recordsEmpty, systemImage: "trophy")
            } else {
                List {
                    Section {
                        controls
                    }
                    Section {
                        ForEach(displayedRecords) { record in
                            RecordRow(record: record)
                        }
                    }
                }
            }
        }
        .navigationTitle(Strings.recordsTitle)
    }

    private var controls: some View {
        VStack(alignment: .leading, spacing: 12) {
            Picker(Strings.recordsSortLabel, selection: $sortOption) {
                ForEach(RecordsSortOption.allCases) { option in
                    Text(option.title).tag(option)
                }
            }
            .pickerStyle(.segmented)

            if playerNames.count > 1 {
                Picker(Strings.recordsFilterLabel, selection: $selectedPlayer) {
                    Text(Strings.recordsFilterAll).tag(String?.none)
                    ForEach(playerNames, id: \.self) { name in
                        Text(name).tag(String?.some(name))
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

private struct RecordRow: View {
    let record: ScoreRecord

    private var dateFormatted: String {
        record.datePlayed.formatted(date: .abbreviated, time: .shortened)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(record.playerName)
                    .font(.headline)
                Spacer()
                Text("\(record.score)")
                    .font(.title3.bold())
            }
            HStack {
                Text(Strings.recordsDifficultyValue(record.difficulty))
                Spacer()
                Text(Strings.recordsDateValue(dateFormatted))
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        RecordsView()
    }
    .modelContainer(for: ScoreRecord.self, inMemory: true)
}

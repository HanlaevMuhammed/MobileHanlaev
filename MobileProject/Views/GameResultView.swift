//
//  GameResultView.swift
//  MobileProject
//

import SwiftUI

struct GameResultView: View {
    @ObservedObject var engine: GameEngine

    private var accuracy: Double {
        let total = engine.hits + engine.misses
        guard total > 0 else { return 0 }
        return Double(engine.hits) / Double(total) * 100
    }

    var body: some View {
        VStack(spacing: 20) {
            Text(Strings.gameResultTitle)
                .font(.title.bold())

            VStack(alignment: .leading, spacing: 8) {
                Text(Strings.gameResultScoreValue(engine.score))
                Text(Strings.gameResultHitsValue(engine.hits))
                Text(Strings.gameResultMissesValue(engine.misses))
                Text(Strings.gameResultAccuracyValue(accuracy))
            }
            .font(.body)

            Spacer()

            VStack(spacing: 12) {
                Button {
                    engine.reset()
                    engine.start()
                } label: {
                    Text(Strings.gameResultPlayAgainButton)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                Button {
                    engine.reset()
                } label: {
                    Text(Strings.gameResultBackButton)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .presentationDetents([.medium, .large])
    }
}

#Preview {
    GameResultView(engine: GameEngine(settings: GameSettings()))
}

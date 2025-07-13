//
//  GameListView.swift
//  MMOBOMBMyArchDemo
//
//  Created by CarlosZR on 9/7/25.
//

import SwiftUI

struct GameListView: View {
    // MARK: - Properties
    @Environment(GameStore.self) private var gameStore
    @State private var games: [Game] = []

    // MARK: - Body
    var body: some View {
        NavigationStack {
            List(games) { game in
                NavigationLink(value: game) {
                    GameRow(game: game)
                }
            }
            .navigationTitle("Games")
            .navigationDestination(for: Game.self) { game in
                GameDetailView(game: game)
            }
            .task {
                do {
                    games = try await gameStore.getAllGames()
                } catch {
                    print("❌ Failed to fetch games: \(error)")
                }
            }
            .onDisappear {
//                Task {
//                    await gameStore.deleteAllLocalGames()
//                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    GameListView()
}

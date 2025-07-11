//
//  GameListView.swift
//  MMOBOMBMyArchDemo
//
//  Created by CarlosZR on 9/7/25.
//

import SwiftUI

struct GameListView: View {
    @Environment(GameStore.self) private var gameStore
    @State private var games: [Game] = []
    

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
            
            
//            Text("Test")
//                .task {
//                    do {
//                        games = try await gameStore.getAllGames()
//                        // Use games as needed
//                    } catch {
//                        print("Failed to fetch games: \(error)")
//                    }
//                }
            
//            List(games) { game in
//                NavigationLink(value: game) {
//                    GameRow(game: game)
//                }
//            }
//            .navigationTitle("Games")
//            .task { await viewModel.loadGames() }
//            .navigationDestination(for: Game.self) { game in
//                GameDetailView(game: game)
//            }
        }
    }
}

#Preview {
    GameListView()
}

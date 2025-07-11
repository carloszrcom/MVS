//
//  GameDetailView.swift
//  MMOBOMBMyArchDemo
//
//  Created by CarlosZR on 9/7/25.
//

import SwiftUI

struct GameDetailView: View {
    let game: Game

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let url = game.thumbnailURL {
                    AsyncImage(url: url) { image in
                        image.resizable().aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }

                Text(game.title).font(.largeTitle).bold()

                Group {
                    if let genre = game.genre {
                        Text("🎮 Genre: \(genre)")
                    }
                    if let platform = game.platform {
                        Text("💻 Platform: \(platform)")
                    }
                    if let publisher = game.publisher {
                        Text("📣 Publisher: \(publisher)")
                    }
                    if let developer = game.developer {
                        Text("👨‍💻 Developer: \(developer)")
                    }
                    if let releaseDate = game.releaseDate {
                        Text("🗓 Release: \(releaseDate.formatted(date: .long, time: .omitted))")
                    }
                }

                Text(game.shortDescription).font(.body)

                if let url = game.gameURL {
                    Link("Play Now", destination: url)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationTitle("Game Details")
    }
}
//#Preview {
//    GameDetailView()
//}

//
//  GameRow.swift
//  MMOBOMBMyArchDemo
//
//  Created by CarlosZR on 9/7/25.
//

import SwiftUI

struct GameRow: View {
    let game: Game

    var body: some View {
        HStack {
            AsyncImage(url: game.thumbnailURL) { img in
                img.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle().fill(.gray.opacity(0.3))
            }
            .frame(width: 60, height: 60)
            .cornerRadius(8)
            
            Text(game.title)
                .font(.headline)
                .lineLimit(2)
        }
    }
}

//#Preview {
//    GameRow()
//}

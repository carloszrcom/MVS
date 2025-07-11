//
//  Game.swift
//  MMOBOMBMyArchDemo
//
//  Created by CarlosZR on 9/7/25.
//

import Foundation

struct Game: Identifiable, Equatable, Hashable {
    let id: GameID
    let title: String
    let thumbnailURL: URL?
    let shortDescription: String
    let gameURL: URL?
    let genre: String?
    let platform: String?
    let publisher: String?
    let developer: String?
    let releaseDate: Date?
    let profileURL: URL?
}

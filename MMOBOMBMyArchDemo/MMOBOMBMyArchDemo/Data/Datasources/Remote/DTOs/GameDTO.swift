//
//  GameDTO.swift
//  MMOBOMBMyArchDemo
//
//  Created by CarlosZR on 9/7/25.
//

import Foundation

struct GameDTO: Decodable {
    let id: Int
    let title: String?
    let thumbnail: String?
    let short_description: String?
    let game_url: String?
    let genre: String?
    let platform: String?
    let publisher: String?
    let developer: String?
    let release_date: String?
    let profile_url: String?
}

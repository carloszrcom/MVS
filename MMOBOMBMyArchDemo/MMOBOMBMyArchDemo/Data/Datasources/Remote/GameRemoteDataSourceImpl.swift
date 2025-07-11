//
//  GameRemoteDataSourceImpl.swift
//  MMOBOMBMyArchDemo
//
//  Created by CarlosZR on 10/7/25.
//

import Foundation

final class GameRemoteDataSourceImpl {
    // MARK: - Properties
    private let url = URL(string: "https://www.mmobomb.com/api1/games")!
    private let session = URLSession.shared

    // MARK: - Functions
    func fetchAllGames() async throws -> [GameDTO] {
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode([GameDTO].self, from: data)
    }
}

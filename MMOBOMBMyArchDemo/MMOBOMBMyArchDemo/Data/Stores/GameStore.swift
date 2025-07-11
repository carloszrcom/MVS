//
//  GameStore.swift
//  MMOBOMBMyArchDemo
//
//  Created by CarlosZR on 10/7/25.
//

import Foundation
import SwiftData

@Observable
class GameStore {
    // MARK: - Properties
    private var modelContext: ModelContext
    private var remote = GameRemoteDataSourceImpl()
    private var local: GameLocalDataSourceImpl
    
    // MARK: - Init
    init(modelContext: ModelContext, remote: GameRemoteDataSourceImpl = GameRemoteDataSourceImpl()) {
        self.modelContext = modelContext
        self.remote = remote
        self.local = GameLocalDataSourceImpl(context: modelContext)
    }
    
    // MARK: - Functions
    func getAllGames() async throws -> [Game] {
        let localDTOs = try await local.fetchAllGames()

        if !localDTOs.isEmpty {
            return localDTOs.map(dtoToDomain)
        }

        let remoteDTOs = try await remote.fetchAllGames()
        try await local.saveAllGames(remoteDTOs)
        return remoteDTOs.map(dtoToDomain)
    }
    
    // MARK: - Private functions
    private func dtoToDomain(_ dto: GameDTO) -> Game {
        let formatter = ISO8601DateFormatter()
        return Game(
            id: GameID(value: dto.id),
            title: dto.title ?? "Untitled",
            thumbnailURL: URL(string: dto.thumbnail ?? ""),
            shortDescription: dto.short_description ?? "No description",
            gameURL: URL(string: dto.game_url ?? ""),
            genre: dto.genre,
            platform: dto.platform,
            publisher: dto.publisher,
            developer: dto.developer,
            releaseDate: formatter.date(from: dto.release_date ?? ""),
            profileURL: URL(string: dto.profile_url ?? ""))
    }
}


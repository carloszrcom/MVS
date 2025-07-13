//
//  GameLocalDataSourceImpl.swift
//  MMOBOMBMyArchDemo
//
//  Created by CarlosZR on 11/7/25.
//

import Foundation
import SwiftData

final class GameLocalDataSourceImpl {
    // MARK: - Properties
    /// IMPORTANT: The `ModelContext` passed here MUST come from a SwiftUI View using `@Environment(\.modelContext)`.
    /// This class is designed to be instantiated once with that context and then injected as a single instance
    /// throughout the app, for example:
    /// `let localDataSource = GameLocalDataSourceImpl(context: context)`
    /// and then passed to other components like `GameStore`.
    private let context: ModelContext
    
    // MARK: - Init
    /// IMPORTANT: The `ModelContext` passed here MUST come from a SwiftUI View using `@Environment(\.modelContext)`.
    /// Instantiate a single instance of this class at app launch or in appropriate scope,
    /// then inject it where needed.
    init(context: ModelContext) {
        self.context = context
    }
    
    deinit {
        print("--> Deinit de GameLocalDataSourceImpl")
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Functions
    func fetchAllGames() async throws -> [GameDTO] {
        let results = try context.fetch(FetchDescriptor<GameEntity>())
        return results.map {
            GameDTO(id: $0.id,
                    title: $0.title,
                    thumbnail: $0.thumbnail,
                    short_description: $0.shortDescription,
                    game_url: $0.gameUrl,
                    genre: $0.genre,
                    platform: $0.platform,
                    publisher: $0.publisher,
                    developer: $0.developer,
                    release_date: $0.releaseDate,
                    profile_url: $0.profileUrl)
        }
    }
    
    func saveAllGames(_ dtos: [GameDTO]) async throws {
        for dto in dtos {
            let entity = GameEntity(id: dto.id,
                                    title: dto.title ?? "",
                                    thumbnail: dto.thumbnail ?? "",
                                    shortDescription: dto.short_description ?? "",
                                    gameUrl: dto.game_url ?? "",
                                    genre: dto.genre ?? "",
                                    platform: dto.platform ?? "",
                                    publisher: dto.publisher ?? "",
                                    developer: dto.developer ?? "",
                                    releaseDate: dto.release_date ?? "",
                                    profileUrl: dto.profile_url ?? "")
            context.insert(entity)
        }
        try context.save()
    }

    func deleteAllGames() async throws {
        let fetchDescriptor = FetchDescriptor<GameEntity>()
        let games = try context.fetch(fetchDescriptor)
        for game in games {
            context.delete(game)
        }
        try context.save()
    }
}

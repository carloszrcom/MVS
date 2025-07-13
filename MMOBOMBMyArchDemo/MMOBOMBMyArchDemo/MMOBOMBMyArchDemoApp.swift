//
//  MMOBOMBMyArchDemoApp.swift
//  MMOBOMBMyArchDemo
//
//  Created by CarlosZR on 9/7/25.
//

import SwiftUI
import SwiftData

@main
struct MMOBOMBMyArchDemoApp: App {
    // MARK: - Properties
    /// SwiftData container.
    private let container: ModelContainer
    private let remoteDataSource = GameRemoteDataSourceImpl()
    @State private var gameStore: GameStore!
    
    // MARK: - Init
    init() {
        // SwiftData
        do {
            let schema = Schema([
                GameEntity.self
            ])
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false,
                allowsSave: true
            )
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            let localDataSource = GameLocalDataSourceImpl(context: container.mainContext)
            self._gameStore = State(initialValue: GameStore(modelContext: container.mainContext, remote: remoteDataSource, local: localDataSource))
        } catch {
            fatalError(">> Could not initialize ModelContainer: \(error)")
        }
    }
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(container)
        .environment(gameStore)
    }
}


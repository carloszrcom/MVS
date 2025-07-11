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
    let container: ModelContainer
    
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
        } catch {
            fatalError(">> Could not initialize ModelContainer: \(error)")
        }
    }
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            GameListView()
                .environment(GameStore(modelContext: container.mainContext))
        }
        .modelContainer(container)
    }
}


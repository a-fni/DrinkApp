//
//  DrinkAppApp.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 20/07/2026.
//

import SwiftUI
import SwiftData

@main
struct DrinkAppApp: App {
    
    // SwiftData setup - data model we will be using
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            AppSettings.self,
            DrinkEntry.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}

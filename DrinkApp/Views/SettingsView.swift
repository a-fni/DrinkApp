//
//  SettingsView.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 20/07/2026.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    
    // MARK: SwiftData connection
    // SwiftData access - will be using the next two fields for storage access
    @Environment(\.modelContext) private var modelContext
    
    // App settings and drink entries are fetched here
    @Query private var appSettings: [AppSettings]
    
    
    // MARK: Body
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SettingsView().modelContainer(for: AppSettings.self, inMemory: true)
}

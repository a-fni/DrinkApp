//
//  ActionButtons.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 21/07/2026.
//

import SwiftUI
import SwiftData

struct ActionButtons: View {
    
    // MARK: SwiftData connection
    // SwiftData access - will be using the next two fields for storage access
    @Environment(\.modelContext) private var modelContext
    
    // App settings and drink entries are fetched here
    @Query private var appSettings:     [AppSettings]
    @Query private var drinkProgress:   [DrinkProgress]


    // MARK: Body
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Button("Drink+", action: drink)
                Button("Drink0", action: resetDrink)
                Button("Target+", action: increaseTarget)
                Button("Target0", action: resetTarget)
            }
            .frame(
                width: geometry.size.width - PAD_RIGHT,
                height: geometry.size.height,
                alignment: .trailing
            )
            .position(
                x: geometry.size.width / 2,
                y: geometry.size.height / 2
            )
        }
    }
    
    
    // MARK: Stub functions (for testing only)
    private func drink() {
        // Safely extract current progress
        guard let drinkProgressEntry = drinkProgress.first else { return }
        
        // Update progress
        drinkProgressEntry.progress += 100
        do {
            try modelContext.save()
        } catch {
            print("Could not update current progress: \(error)")
        }
        
        // Updating state values
        self.updateEnvironment()
    }
    
    private func resetDrink() {
        // Safely extract current progress
        guard let drinkProgressEntry = drinkProgress.first else { return }
        
        // Update progress
        drinkProgressEntry.progress = 0
        do {
            try modelContext.save()
        } catch {
            print("Could not reset current progress: \(error)")
        }
        
        // Updating state values
        self.updateEnvironment()
    }
    
    private func increaseTarget() {
        // Safely extract current progress
        guard let appSettingsEntry = appSettings.first else { return }
        
        // Update progress
        appSettingsEntry.targetAmount += 100
        do {
            try modelContext.save()
        } catch {
            print("Could not update target amount: \(error)")
        }
        
        // Updating state values
        self.updateEnvironment()
    }
    
    private func resetTarget() {
        // Safely extract current progress
        guard let appSettingsEntry = appSettings.first else { return }
        
        // Update progress
        appSettingsEntry.targetAmount = 0
        do {
            try modelContext.save()
        } catch {
            print("Could not reset target amount: \(error)")
        }
        
        // Updating state values
        self.updateEnvironment()
    }
    
    
    private func updateEnvironment() {}
}

#Preview {
    ActionButtons().modelContainer(for: DrinkProgress.self, inMemory: true)
}

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
                // Increase button
                Button {
                    increaseLevel()
                } label: {
                    Image(systemName: "plus.circle")
                }
                
                Spacer(minLength: 50)
                
                // Decrease button
                Button {
                    decreaseLevel()
                } label: {
                    Image(systemName: "minus.circle")
                }
                
                Spacer(minLength: 50)
                
                // Configuration buttons
                Button {
                    configure()
                } label: {
                    Image(systemName: "gear")
                }
            }
            .frame(
                width: geometry.size.width - PAD_RIGHT,
                height: 0,
                alignment: .trailing
            )
            .position(
                x: geometry.size.width / 2,
                y: geometry.size.height / 2
            )
        }
    }
    
    
    // MARK: Stub functions (for testing only)
    private func increaseLevel() {
        // Safely extract current progress
        guard let drinkProgressEntry = drinkProgress.first else { return }
        
        // Update progress
        drinkProgressEntry.progress += 100
        if drinkProgressEntry.progress > 10_000 {
            drinkProgressEntry.progress = 10_000
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Could not update current progress: \(error)")
        }
    }
    
    private func decreaseLevel() {
        // Safely extract current progress
        guard let drinkProgressEntry = drinkProgress.first else { return }
        
        // Update progress
        drinkProgressEntry.progress -= 100
        if drinkProgressEntry.progress < 0 {
            drinkProgressEntry.progress = 0
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Could not reset current progress: \(error)")
        }
    }
    
    private func configure() {}

}

#Preview {
    ActionButtons().modelContainer(for: DrinkProgress.self, inMemory: true)
}

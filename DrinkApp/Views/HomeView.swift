//
//  HomeView.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 20/07/2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    // MARK: SwiftData connection
    // SwiftData access - will be using the next two fields for storage access
    @Environment(\.modelContext) private var modelContext
    
    // App settings and drink entries are fetched here
    @Query private var appSettings:     [AppSettings]
    @Query private var drinkProgress:   [DrinkProgress]
    
    
    // MARK: Body of the view
    var body: some View {
        // Computing UI rendering parameters
        let ml: Int = drinkProgress.first?.progress ?? 0
        let mlTarget: Int = appSettings.first?.targetAmount ?? 1500
        let mlMin   = HomeView.computeMin(ml: ml, target: mlTarget)
        let mlMax   = HomeView.computeMax(ml: ml, target: mlTarget)
        let mlStep  = HomeView.computeStep(mlMin: mlMin, mlMax: mlMax)
        
        // Construcing scene as ZStack
        ZStack {
            // Water level is first layer
            WaterLevel(
                ml: drinkProgress.first?.progress ?? 0,
                mlMin: mlMin,
                mlMax: mlMax,
            )
            
            // Measuring tick marks second layer
            TickMarkers(
                mlMin: mlMin,
                mlMax: mlMax,
                step:  mlStep
            )
            
            // Then we have the target tick mark layer
            TickMark(
                ml: appSettings.first?.targetAmount ?? 0,
                mlMin: mlMin,
                mlMax: mlMax,
                colour: .yellow
            )
            
            // Next, the current level tick mark
            TickMark(
                ml: drinkProgress.first?.progress ?? 0,
                mlMin: mlMin,
                mlMax: mlMax,
                colour: .green
            )
            
            // Finally, we add the control bottons as the last layer
            ActionButtons()
        }
        .onAppear() {
            initializeStoredData()
        }
    }
    
    
    // MARK: custom methods
    private func initializeStoredData() {
        // Check if drink progress has a value stored (should be exactly one)
        // TODO: Update behaviour to store also history of past values
        if drinkProgress.count > 1 {
            for drinkProgressEntry in drinkProgress {
                modelContext.delete(drinkProgressEntry)
            }
        }
        if drinkProgress.count == 0 {
            modelContext.insert(DrinkProgress())
        }
        
        // Check if current drink progress is relevant for today.
        // If it isn't, reset progress before returning
        let drinkProgressEntry: DrinkProgress = drinkProgress.first!
        if !Calendar.current.isDateInToday(drinkProgressEntry.referenceTimestamp) {
            drinkProgressEntry.progress = 0
            drinkProgressEntry.referenceTimestamp = Date()
        }
        
        // Initializing appSettings as well
        if appSettings.count > 1 {
            for appSettingsEntry in appSettings {
                modelContext.delete(appSettingsEntry)
            }
        }
        if appSettings.count == 0 {
            modelContext.insert(AppSettings())
        }
        
        // Saving updates
        do {
            try modelContext.save()
        } catch {
            print("Could not initialize SwiftData: \(error)")
        }
    }
    
    
    // MARK: Static functions for utility computations
    private static func computeMin(ml: Int, target: Int) -> Int {
        // Currently no reason to have mlMin at a different value
        return 0
    }
    
    private static func computeMax(ml: Int, target: Int) -> Int {
        // Margin percentage factor and we impose a minimum maximum value of 2L
        let margin: Float = 1.0
        let minimumMaximum: Int = Int(ceil(Float(2000) / margin))
        
        // Add 10% to maximum between current ml and target ml
        return Int(ceil(Float(max(ml, target, minimumMaximum)) * margin))
    }
    
    private static func computeStep(mlMin: Int, mlMax: Int) -> Int {
        // We want to see at most 8 ticks overall
        let maximumTicks: Int = 8
        return Int(Float(mlMax - mlMin) / Float(maximumTicks))
    }
    
}

#Preview {
    HomeView().modelContainer(for: DrinkProgress.self, inMemory: true)
}

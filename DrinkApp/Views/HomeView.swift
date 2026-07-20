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
    
    
    // MARK: State variables
    @State private var ml: Int
    @State private var mlMin: Int
    @State private var mlMax: Int

    
    // MARK: Struct constructor (for state variables)
//    init(ml: Int, mlMin: Int, mlMax: Int) {
    init() {
        _ml = State(initialValue: 0)
        _mlMin = State(initialValue: HomeView.computeMin(ml: 0, target: 0))
        _mlMax = State(initialValue: HomeView.computeMax(ml: 0, target: 0))
    }
    
    
    // MARK: Body of the view
    var body: some View {
        ZStack {
            TickMarkers(mlMin: self.mlMin, mlMax: self.mlMax, step: 500)
            TickMark(ml: self.ml, mlMin: self.mlMin, mlMax: self.mlMax, colour: .green)
            TickMark(ml: 200, mlMin: self.mlMin, mlMax: self.mlMax, colour: .yellow)
            //WaterLevel(at: getTotalAmountDrunk(), )
        }

    }

    
    // MARK: custom functions
    private func getCurrentProgress() -> Int {
        // Check if drink progress has a value stored (should be exactly one)
        // TODO: Update behaviour to store also history of past values
        if drinkProgress.count > 1 {
            for drinkProgressEntry in drinkProgress {
                modelContext.delete(drinkProgressEntry)
            }
        }
        if drinkProgress.count == 0 {
            modelContext.insert(
                DrinkProgress()
            )
        }
        
        // Check if current drink progress is relevant for today.
        // If it isn't, reset progress before returning
        let drinkProgressEntry = drinkProgress[0]
        if !Calendar.current.isDateInToday(drinkProgressEntry.referenceTimestamp) {
            drinkProgressEntry.progress = 0
        }
            
        // Simply retrieve the current progress value
        return drinkProgressEntry.progress
    }
    
    
    // MARK: Static functions
    private static func computeMin(ml: Int, target: Int) -> Int {
        // Currently no reason to have mlMin at a different value
        return 0
    }
    
    private static func computeMax(ml: Int, target: Int) -> Int {
        // Add 10% to maximum between current ml and target ml
        return Int(ceil(Float(max(ml, target, 2000)) * 1.1))
    }
    
}

#Preview {
    HomeView().modelContainer(for: DrinkProgress.self, inMemory: true)
}

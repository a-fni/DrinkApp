//
//  AppSettings.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 20/07/2026.
//

import Foundation
import SwiftData

// Class describing the internal data item structure
@Model
final class AppSettings {

    // Fields
    var targetAmount_min: Float     // Target amount of water range min
    var targetAmount_max: Float     // Target amount of water range max

    var waterGlassAmount: Int       // Amount of water of a glass in ml (usually 150)
    
    
    init(targetAmount_min: Float, targetAmount_max: Float, waterGlassAmount: Int) {
        // Main class constructor simply initializes variables
        self.targetAmount_min = targetAmount_min
        self.targetAmount_max = targetAmount_max
        
        self.waterGlassAmount = waterGlassAmount
    }
}

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
    var targetAmount: Float     // Target amount of water
    var waterGlassAmount: Int   // Amount of water of a glass in ml (usually 150)
    
    
    init(targetAmount: Float, waterGlassAmount: Int) {
        // Main class constructor simply initializes variables
        self.targetAmount = targetAmount
        self.waterGlassAmount = waterGlassAmount
    }
}

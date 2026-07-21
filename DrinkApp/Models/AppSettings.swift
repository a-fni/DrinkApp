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
    var targetAmount: Int       // Target amount of water in ml
    var waterGlassAmount: Int   // Amount of water of a glass in ml (usually 150)
    
    
    init() {
        // Main class constructor simply initializes variables
        self.targetAmount     = 2000
        self.waterGlassAmount = 150
    }
}

//
//  DrinkEntry.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 20/07/2026.
//

import Foundation
import SwiftData

// Class describing the internal data item structure
@Model
final class DrinkEntry {

    // Fields
    var amount: Int         // Single water drinking event in ml
    var timestamp: Date     // Time of water drinking event
    
    init(amount: Int, timestamp: Date) {
        // Main class constructor simply initializes variables
        self.amount = amount
        self.timestamp = timestamp
    }
}

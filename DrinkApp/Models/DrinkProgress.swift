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
final class DrinkProgress {

    // Fields
    var progress: Int               // Current drinking progress
    var referenceTimestamp: Date    // Reference date for current progress measuring
    
    init() {
        // Main class constructor simply initializes progress to 0 and timestamp to Date()
        self.progress = 0
        self.referenceTimestamp = Date()
    }
}

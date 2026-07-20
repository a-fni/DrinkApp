//
//  TickMarkers.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 20/07/2026.
//

import SwiftUI

struct TickMarkers: View {
    
    // MARK: Fields
    let mlMin: Int      // Minimum value to display in ml
    let mlMax: Int      // Maximum value to display in ml
    let step: Int       // Step to use in ml
    
    // MARK: Body
    var body: some View {
        ZStack {
            ForEach(
                Array(stride(from: self.mlMin, through: self.mlMax, by: step)),
                id: \.self
            ) { ml in
                TickMark(
                    ml: ml,
                    mlMin: self.mlMin,
                    mlMax: self.mlMax,
                    colour: .gray
                )
            }
        }
    }

}

#Preview {
    TickMarkers(mlMin: 0, mlMax: 1500, step: 250)
}

//
//  TickMark.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 20/07/2026.
//

import SwiftUI

struct TickMark: View {
    
    // MARK: Fields
    let ml: Int
    let mlMin: Int
    let mlMax: Int
    
    let colour: Color
    
    
    // MARK: Body
    var body: some View {
        // Render as full-width frame with correct placing at width/2
        // Height is derived directly from ml value
        GeometryReader { geometry in
            HStack {
                Rectangle()
                    .fill(self.colour)
                    .frame(
                        width:  TICK_WIDTH,
                        height: TICK_HEIGHT
                    )
                Text("\(ml)ml")
            }
            .frame(
                width: geometry.size.width,
                alignment: .leading
            )
            .position(
                x: geometry.size.width / 2,
                y: mapFrom(
                    ml: self.ml,
                    givenMin: self.mlMin,
                    givenMax: self.mlMax,
                    screenHeight: geometry.size.height
                ),
            )
        }
    }
}

#Preview {
    TickMark(
        ml: 1000,
        mlMin: 0,
        mlMax: 1500,
        colour: .gray
    )
}

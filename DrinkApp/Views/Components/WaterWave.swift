//
//  WaterWave.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 20/07/2026.
//

import SwiftUI

struct WaterWave: Shape {
    
    // MARK: Fields
    let ml: Int
    let mlMin: Int
    let mlMax: Int
    let waveHeight: CGFloat = 10  // In pixels
    
    // Animation offset
    var offset: CGFloat
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    
    // MARK: Drawing wave as Path
    func path(in rect: CGRect) -> Path {
        Path { path in
            // Drawing waves using sine
            let progressHeight: CGFloat = mapFrom(
                ml: self.ml,
                givenMin: self.mlMin,
                givenMax: self.mlMax,
                screenHeight: rect.height
            )
            
            // Iterating over width by hops of precision pixels and plotting lines following
            // a sinusoidal trajectory, making the path wave like
            let precision: CGFloat = 2
            var firstPoint: Bool = true
            for value in stride(from: 0, to: rect.width + precision, by: precision) {
                let normalizedRadians: CGFloat = (value - offset) / rect.width * 2 * Double.pi
                
                let x: CGFloat = value
                let sine: CGFloat = sin(normalizedRadians)
                let y: CGFloat = progressHeight - (self.waveHeight * sine)
                
                // For first point, instead of creating a line we move to the coordinate
                if firstPoint {
                    firstPoint = false
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            
            // Closing shape on the bottom. Note we go further down than screen height
            // to ensure we fill the entire display
            path.addLine(to: CGPoint(x: rect.width, y: rect.height * 1.5))
            path.addLine(to: CGPoint(x: 0, y: rect.height * 1.5))
        }
    }
}

#Preview {
    WaterWave(
        ml: 500,
        mlMin: 0,
        mlMax: 2000,
        offset: 0.0
    )
}

//
//  WaterLevel.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 20/07/2026.
//

import SwiftUI

struct WaterLevel: View {
    
    // MARK: State values and fields
    let ml: Int
    let mlMin: Int
    let mlMax: Int
    
    @State var startAnimation: CGFloat = 0
    
    
    // MARK: Body
    var body: some View {
        VStack {
            // MARK: Wave Form
            GeometryReader { geometry in
                ZStack {
                    // Wave Form Shape
                    WaterWave(
                        ml: self.ml,
                        mlMin: self.mlMin,
                        mlMax: self.mlMax,
                        offset: startAnimation
                    )
                        .fill(LinearGradient(
                            gradient:   Gradient(colors: [.cyan, .indigo]),
                            startPoint: .top,
                            endPoint:   .bottom
                        ))
                        .stroke(.indigo, style: StrokeStyle(lineWidth: 3))
                }
                .onAppear {
                    // Looping animation
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                        startAnimation = geometry.size.width
                    }
                }
            }
        }
    }
}

#Preview {
    WaterLevel(
        ml: 200,
        mlMin: 0,
        mlMax: 2000
    )
}

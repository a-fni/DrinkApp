//
//  TargetTickMark.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 21/07/2026.
//

import SwiftUI
import SwiftData

struct TargetMark: View {
    
    // MARK: SwiftData connection
    // SwiftData access - will be using the next two fields for storage access
    @Environment(\.modelContext) private var modelContext
    
    // App settings and drink entries are fetched here
    @Query private var appSettings: [AppSettings]
    
    
    // MARK: Fields and state values
    let ml: Int
    let mlMin: Int
    let mlMax: Int
    
    @State private var mlTargetLabel: Int
    @State private var dragOffset: CGFloat = 0
    
    
    init(ml: Int, mlMin: Int, mlMax: Int) {
        self.ml = ml
        self.mlMin = mlMin
        self.mlMax = mlMax
        
        // Will use this state value to dynamically update the target level
        // while it is being changed by dragging
        self._mlTargetLabel = State(initialValue: ml)
    }
    
    
    // MARK: Body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("\(mlTargetLabel)ml")
                    .frame(
                        width:  geometry.size.width,
                    )
                    .position(
                        x: geometry.size.width / 2,
                        y: mapFrom(
                            ml: self.ml,
                            givenMin: self.mlMin,
                            givenMax: self.mlMax,
                            screenHeight: geometry.size.height
                        ) - 3 * TARGET_HEIGHT,
                    )
                Rectangle()
                    .fill(.yellow)
                    .frame(
                        width:  geometry.size.width,
                        height: TARGET_HEIGHT
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
            .frame(
                width: geometry.size.width,
                alignment: .bottom
            )
            .offset(
                x: 0,
                y: dragOffset
            )
            .gesture(
                DragGesture()
                .onChanged({ value in
                    // When target is moved, simply move it on screen too
                    self.dragOffset = value.translation.height
                    self.mlTargetLabel = convertOffsetToMl(
                        offset: self.dragOffset,
                        height: geometry.size.height
                    )
                })
                .onEnded({ value in
                    // When dragging ends, update target in memory
                    updateTarget(
                        delta: self.dragOffset,
                        height: geometry.size.height
                    )
                    self.dragOffset = 0
                })
            )
        }
    }
    
    
    // MARK: Custom functions
    func updateTarget(delta: CGFloat, height: CGFloat) {
        // Obtaining AppSettings object
        guard let appSettingsEntry = appSettings.first else { return }
        
        // Extracting ml value from dragged offset
        let mlNew = convertOffsetToMl(offset: delta, height: height)
        
        // Updating stored data and target label
        appSettingsEntry.targetAmount = mlNew
        self.mlTargetLabel = mlNew
    }
    
    func convertOffsetToMl(offset: CGFloat, height: CGFloat) -> Int {
        // Extracting previous y-coordinate and computing current new one
        let yCoordOld = mapFrom(
            ml: self.ml,
            givenMin: self.mlMin,
            givenMax: self.mlMax,
            screenHeight: height
        )
        let yCoordNew = yCoordOld + offset
        
        // Inverting current pixel height into ml amount. We round up the value to nearest 50
        let mlNew = mapFrom(
            pixels: yCoordNew,
            givenMin: self.mlMin,
            givenMax: self.mlMax,
            screenHeight: height
        )
        let mlNewRounded = Int((Float(mlNew) / 50.0).rounded()) * 50
        return min(max(mlNewRounded, 0), 10_000)
    }
}

#Preview {
    TargetMark(
        ml: 500,
        mlMin: 0,
        mlMax: 2000
    ).modelContainer(for: AppSettings.self, inMemory: true)
}

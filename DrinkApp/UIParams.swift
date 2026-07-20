//
//  UIParams.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 20/07/2026.
//

import Foundation


// MARK: Sizes for ticks
let TICK_WIDTH:  CGFloat = 30
let TICK_HEIGHT: CGFloat = 10


// MARK: Screen padding to use
let PAD_TOP:    CGFloat = 25
let PAD_RIGHT:  CGFloat = 0
let PAD_BOTTOM: CGFloat = 25
let PAD_LEFT:   CGFloat = 0



// MARK: Functions
func mapFrom(
    ml: Int,
    givenMin mlMin: Int,
    givenMax mlMax: Int,
    screenHeight: CGFloat
) -> CGFloat {
    let effectiveScreenHeight: CGFloat = screenHeight - PAD_TOP - PAD_BOTTOM
    let unitPixels: CGFloat = effectiveScreenHeight / CGFloat(mlMax - mlMin)
    let yCoord: CGFloat = unitPixels * CGFloat(ml - mlMin)
    let yCoordAdjusted: CGFloat = yCoord + PAD_TOP
    return screenHeight - yCoordAdjusted
}

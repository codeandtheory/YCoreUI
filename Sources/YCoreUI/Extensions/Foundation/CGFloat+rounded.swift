//
//  CGFloat+rounded.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 8/10/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

extension CGFloat {
    /// Rounds float to 1/scale, e.g. 0.5 on 2x scale, or 0.333 on 3x scale.
    /// Useful for pixel-perfect view alignment or drawing.
    /// - Parameters:
    ///   - rule: rounding rule to apply, default is schoolbook rounding
    ///   - scale: the scale to apply (e.g. 2.0 or 3.0)
    /// - Returns: the value rounded 1/scale
    public func rounded(
        _ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero,
        scale: UIScreen.ScaleFactor
    ) -> CGFloat {
        (self * scale.rawValue).rounded(rule) / scale.rawValue
    }
    
    /// Floors float to 1/scale, e.g. round down to nearest 0.5 on 2x scale, or 0.333 on 3x scale.
    /// Useful for calculating pixel-aligned origins (left, top).
    /// - Parameter scale: the scale to apply, default is current screen scale
    /// - Returns: the value floored to 1/scale
    public func floored(scale: UIScreen.ScaleFactor = UIScreen.main.scaleFactor) -> CGFloat {
        rounded(.down, scale: scale)
    }
    
    /// Ceils float to 1/scale, e.g. round up to nearest 0.5 on 2x scale, or 0.333 on 3x scale.
    /// Useful for calculating pixel-aligned width & height.
    /// - Parameter scale: the scale to apply, default is current screen scale
    /// - Returns: the value ceiled to 1/scale
    public func ceiled(scale: UIScreen.ScaleFactor = UIScreen.main.scaleFactor) -> CGFloat {
        rounded(.up, scale: scale)
    }
}

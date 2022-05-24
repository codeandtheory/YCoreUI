//
//  UIColor+blended.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 10/11/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

public extension UIColor {
    /// Lightens the receiving color by blending it with white.
    /// - Parameter amount: the amount of white to blend in, ranging from 0 (0% white) to 1 (100% white).
    ///   The value is constrained to a minimum of 0 and a maximum of 1.
    ///   Default = 0.5 (50% white).
    /// - Returns: The lightened color
    /// - Warning: The receiving color must be addressible in the rgba color space.
    func lightened(by amount: CGFloat = 0.5) -> UIColor {
        blended(by: amount, with: .white)
    }

    /// Darkens the receiving color by blending it with black.
    /// - Parameter amount: the amount of black to blend in, ranging from 0 (0% black) to 1 (100% black).
    ///   The value is constrained to a minimum of 0 and a maximum of 1.
    ///   Default = 0.5 (50% black).
    /// - Returns: The darkened color
    /// - Warning: The receiving color must be addressible in the rgba color space.
    func darkened(by amount: CGFloat = 0.5) -> UIColor {
        blended(by: amount, with: .black)
    }

    /// Blends the receiving color with another color.
    /// - Parameters:
    ///   - amount: the amount of the other color to blend in, ranging from 0 (0% other color) to 1 (100% other color).
    ///   The value is constrained to a minimum of 0 and a maximum of 1.
    ///   Default = 0.5 (50/50 blend of each color).
    ///   - otherColor: the other color to blend with the receiving color
    /// - Returns: The blended color
    /// - Warning: Both colors must be addressible in the rgba color space.
    func blended(by amount: CGFloat = 0.5, with otherColor: UIColor) -> UIColor {
        let factor = max(min(amount, 1), 0)

        guard factor != 0 else { return self }
        guard factor != 1 else { return otherColor }

        let rgba1 = self.rgbaComponents
        let rgba2 = otherColor.rgbaComponents

        return UIColor(
            red: rgba1.red * (1 - factor) + (rgba2.red * factor),
            green: rgba1.green * (1 - factor) + (rgba2.green * factor),
            blue: rgba1.blue * (1 - factor) + (rgba2.blue * factor),
            alpha: rgba1.alpha * (1 - factor) + (rgba2.alpha * factor)
        )
    }
}

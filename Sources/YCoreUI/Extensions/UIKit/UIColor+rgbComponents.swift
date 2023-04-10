//
//  UIColor+rgbComponents.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 11/2/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

// This relatively simple tuple (four float values representing the color channels)
// is already a released public api.
// swiftlint:disable superfluous_disable_command large_tuple

/// Tuple representing Red, Green, Blue, and Alpha color channel components
public typealias RGBAComponents = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

public extension UIColor {
    /// Returns the RGBA color channel components for this color.
    /// Values range from 0.0 to 1.0 in the sRGB color space.
    var rgbaComponents: RGBAComponents {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}
// swiftlint: enable superfluous_disable_command large_tuple

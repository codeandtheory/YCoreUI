//
//  UIColor+rgb.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 9/29/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

extension UIColor {
    /// Create a color from a RGB hex value
    /// - Parameters:
    ///   - rgb: RGB hex value (anything about 0xFFFFFF will be masked out and ignored)
    ///   - alpha: alpha value
    public convenience init(rgb: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

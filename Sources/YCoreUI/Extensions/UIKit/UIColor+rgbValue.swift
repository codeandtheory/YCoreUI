//
//  UIColor+rgbValue.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 11/2/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

public extension UIColor {
    /// Formats a color as an RGB hexadecimal string
    /// - Parameters:
    ///   - prefix: optional prefix to precede the hexadecimal value such as `0x` or `#` (default = nil)
    ///   - isUppercase: whether the hex values should be upper or lower case
    /// - Returns: the formatted hexadecimal string
    func rgbDisplayString(prefix: String? = nil, isUppercase: Bool = true) -> String {
        let comp = rgbaComponents
        let format = isUppercase ? "%02X%02X%02X" : "%02x%02x%02x"
        let value = String(
            format: format,
            Int(round(comp.red * 255)),
            Int(round(comp.green * 255)),
            Int(round(comp.blue * 255))
        )
        return "\(prefix ?? "")\(value)"
    }
}

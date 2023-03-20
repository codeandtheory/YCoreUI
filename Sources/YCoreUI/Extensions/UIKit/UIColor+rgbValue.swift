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
        _rgbDisplayString(prefix: prefix, isUppercase: isUppercase, isDebug: false)
    }

    /// Formats a color as an RGB hexadecimal string. Appropriate for debug printing.
    /// - Parameters:
    ///   - prefix: optional prefix to precede the hexadecimal value such as `0x` or `#` (default = nil)
    ///   - isUppercase: whether the hex values should be upper or lower case
    /// - Returns: the formatted hexadecimal string (with an `⚠️` for colors that fall outside of the sRGB color space)
    func rgbDebugDisplayString(prefix: String? = nil, isUppercase: Bool = true) -> String {
        _rgbDisplayString(prefix: prefix, isUppercase: isUppercase, isDebug: true)
    }

    private func _rgbDisplayString(prefix: String?, isUppercase: Bool, isDebug: Bool) -> String {
        let comp = rgbaComponents
        let format = isUppercase ? "%02X%02X%02X" : "%02x%02x%02x"
        let r = Int(round(comp.red * 255))
        let g = Int(round(comp.green * 255))
        let b = Int(round(comp.blue * 255))
        let isRGB = (r >= 0 && r <= 255) && (g >= 0 && g <= 255) && (b >= 0 && b <= 255)
        let value = String(
            format: format,
            min(max(r, 0), 255),
            min(max(g, 0), 255),
            min(max(b, 0), 255)
        )
        if !isRGB && YCoreUI.isLoggingEnabled {
            YCoreUI.colorLogger.warning("Color \(self) falls outside of the sRGB color space.")
        }
        return "\(prefix ?? "")\(value)\(isDebug && !isRGB ? "⚠️" : "")"
    }
}

//
//  UIColor+WCAG.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 10/13/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

// Based upon:
// https://gist.github.com/lkoskela/c06670ded4d01a1832bd90066e76a0a8
//

/// How the colors being compared are being used
public enum WCAGContext {
    /// Normal text, less than 18 pts (Bold less than 14 pts)
    case normalText
    /// Large text, 18 pts or greater (Bold 14 pts or greater)
    case largeText
    /// Graphical object or user interface component
    case uiComponent
    
    /// minimum required contrast to meet the WCAG 2.0 AA standard for this context type
    public var thresholdAA: CGFloat {
        switch self {
        case .normalText:
            return 4.5
        case .largeText:
            return 3.0
        case .uiComponent:
            return 3.0
        }
    }
    
    /// minimum required contrast to meet the WCAG 2.0 AAA standard for this context type
    /// - Warning: Returns `.nan` for `uiComponent` because there is no AAA standard defined for UI components.
    public var thresholdAAA: CGFloat {
        switch self {
        case .normalText:
            return 7.0
        case .largeText:
            return 4.5
        case .uiComponent:
            return .nan // there is no AAA threshold for UI components
        }
    }
    
    /// Returns the threshold level for the specified context and level
    /// - Parameter level: AA or AAA
    /// - Returns: the minimum contrast ratio required to meet the specified level for this context type
    public func threshold(for level: WCAGLevel) -> CGFloat {
        switch level {
        case .AA: return thresholdAA
        case .AAA: return thresholdAAA
        }
    }
}

/// WCAG 2.0 Accessibility level
public enum WCAGLevel {
    /// WCAG 2.0 AA accessibility level
    case AA
    /// WCAG 2.0 AAA accessibility level
    case AAA
}

extension UIColor {
    /// Helper method for calculations used in `luminance`
    private func inverseGammasRGB(_ channelValue: CGFloat) -> CGFloat {
        if channelValue <= 0.03928 {
            return channelValue / 12.92
        }

        return pow(((channelValue + 0.055) / 1.055), 2.4)
    }
    
    /// Relative luminance of a color according to W3's WCAG 2.0:
    /// https://www.w3.org/TR/WCAG20/#relativeluminancedef
    private var luminance: CGFloat {
        let rgba = rgbaComponents
        
        return 0.2126 * inverseGammasRGB(rgba.red) +
            0.7152 * inverseGammasRGB(rgba.green) +
            0.0722 * inverseGammasRGB(rgba.blue)
    }

    /// Contrast ratio between two colors according to W3's WCAG 2.0:
    /// https://www.w3.org/TR/WCAG20/#contrast-ratiodef
    /// - Parameter otherColor: the color to calculate contrast ratio with
    /// - Returns: the contrast ratio between the two colors ranging from 1.0 (identical) to 21.0
    /// (the contrast between pure white and pure black)
    public func contrastRatio(to otherColor: UIColor) -> CGFloat {
        let ourLuminance = self.luminance
        let theirLuminance = otherColor.luminance
        let lighterColor = min(ourLuminance, theirLuminance)
        let darkerColor = max(ourLuminance, theirLuminance)
        return 1 / ((lighterColor + 0.05) / (darkerColor + 0.05))
    }

    /// Determines whether the contrast between this `UIColor` and the provided
    /// `UIColor` is sufficient to meet the recommendations of W3's WCAG 2.0.
    ///
    /// The recommendation is that the contrast ratio between text and its
    /// background should be at least 4.5 : 1 for small text and at least
    /// 3.0 : 1 for larger text.
    /// - Parameters:
    ///   - otherColor: the other color to compute contrast with
    ///   - context: the context of the color comparison (default = `.normalText`)
    ///   - level: the WCAG standard to test against (default = `.AA`)
    /// - Returns: `true` if the two colors meet the specified WCAG minimum contrast ratio, otherwise `false`
    /// - Warning: Combining context == `.uiComponent` and level == `.AAA` will return `false` for all color pairings
    /// because there is no AAA contrast threshold level defined for UI Components.
    public func isSufficientContrast(
        to otherColor: UIColor,
        context: WCAGContext = .normalText,
        level: WCAGLevel = .AA
    ) -> Bool {
        let threshold = context.threshold(for: level)
        return contrastRatio(to: otherColor) > threshold
    }
}

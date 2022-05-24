//
//  UITraitCollection+colorSpaces.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 10/13/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

public extension UITraitCollection {
    /// Trait collections for the various color spaces we support:
    /// 1. Light Mode x Normal Contrast
    /// 2. Light Mode x High Contrast
    /// 3. Dark Mode x Normal Contrast
    /// 4. Dark Mode x High Contrast
    /// Use this to iterate across all color spaces when unit testing your app's colors.
    static let allColorSpaces: [UITraitCollection] = [
        UITraitCollection(userInterfaceStyle: .light),
        UITraitCollection(traitsFrom: [
            UITraitCollection(userInterfaceStyle: .light),
            UITraitCollection(accessibilityContrast: .high)
        ]),
        UITraitCollection(userInterfaceStyle: .dark),
        UITraitCollection(traitsFrom: [
            UITraitCollection(userInterfaceStyle: .dark),
            UITraitCollection(accessibilityContrast: .high)
        ])
    ]
}

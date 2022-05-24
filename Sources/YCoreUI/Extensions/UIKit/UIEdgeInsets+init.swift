//
//  UIEdgeInsets+init.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 4/29/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {
    /// Creates edge insets with the same value on all four sides.
    /// - Parameter value: amount to inset (positive) all four edges. Values can be negative to 'outset'
    init(all value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }

    /// Creates edge insets with one value for vertical edges and another value for horizontal edges.
    /// - Parameters:
    ///   - vertical: amount to inset (positive) top and bottom. Values can be negative to 'outset'
    ///   - horizontal: amount to inset (positive) left and right. Values can be negative to 'outset'
    ///   (defaults to `0`)
    init(topAndBottom vertical: CGFloat, leftAndRight horizontal: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    /// Creates edge insets with the same value on horizontal edges (and 0 for vertical edges)
    /// - Parameter horizontal: amount to inset (positive) left and right. Values can be negative to 'outset'
    init(leftAndRight horizontal: CGFloat) {
        self.init(top: 0, left: horizontal, bottom: 0, right: horizontal)
    }
}

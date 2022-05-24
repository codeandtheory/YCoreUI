//
//  NSDirectionalEdgeInsets+init.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 4/29/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import UIKit

public extension NSDirectionalEdgeInsets {
    /// Creates edge insets with the same value on all four sides.
    /// - Parameter value: amount to inset (positive) all four edges. Values can be negative to 'outset'
    init(all value: CGFloat) {
        self.init(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Creates edge insets with one value for vertical edges and another value for horizontal edges.
    /// - Parameters:
    ///   - vertical: amount to inset (positive) top and bottom. Values can be negative to 'outset'
    ///   - horizontal: amount to inset (positive) leading and trailing. Values can be negative to 'outset'
    ///   (defaults to `0`)
    init(topAndBottom vertical: CGFloat, leadingAndTrailing horizontal: CGFloat = 0) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// Creates edge insets with the same value on horizontal edges (and 0 for vertical edges)
    /// - Parameter horizontal: amount to inset (positive) leading and trailing. Values can be negative to 'outset'
    init(leadingAndTrailing horizontal: CGFloat) {
        self.init(top: 0, leading: horizontal, bottom: 0, trailing: horizontal)
    }
}

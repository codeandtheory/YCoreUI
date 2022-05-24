//
//  Anchorable.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 12/3/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

/// Anything that exposes layout anchors.
/// In our use this will be UIView and UILayoutGuide.
/// This abstracts away the differences between them such that we can pass
/// either a view or a layout guide to our `constrain` methods that act upon anchors.
public protocol Anchorable {
    /// Leading anchor
    var leadingAnchor: NSLayoutXAxisAnchor { get }

    /// Trailing anchor
    var trailingAnchor: NSLayoutXAxisAnchor { get }

    /// Left anchor (most often you should use `leadingAnchor` instead)
    var leftAnchor: NSLayoutXAxisAnchor { get }

    /// Right anchor (most often you should use `trailingAnchor` instead)
    var rightAnchor: NSLayoutXAxisAnchor { get }

    /// Top anchor
    var topAnchor: NSLayoutYAxisAnchor { get }

    /// Bottom anchor
    var bottomAnchor: NSLayoutYAxisAnchor { get }

    /// Width anchor
    var widthAnchor: NSLayoutDimension { get }

    /// Height anchor
    var heightAnchor: NSLayoutDimension { get }

    /// Center x anchor
    var centerXAnchor: NSLayoutXAxisAnchor { get }

    /// Center y anchor
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

// UIView already conforms to Anchorable
// (and has two other anchors for baselines that UILayoutGuide does not have)
extension UIView: Anchorable { }

// UILayoutGuide already conforms to Anchorable
extension UILayoutGuide: Anchorable { }

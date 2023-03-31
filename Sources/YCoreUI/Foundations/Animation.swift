//
//  Animation.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 3/30/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

/// Specifies the parameters to perform animations.
///
/// To be used with `UIView.animate(parameters:animations:completion:)`.
public struct Animation: Equatable {
    /// Animation curve
    public enum Curve: Equatable {
        /// Regular animation curve
        case regular(options: UIView.AnimationOptions)
        /// Spring animation
        case spring(damping: CGFloat, velocity: CGFloat, options: UIView.AnimationOptions = [])
    }

    /// Duration of the animation (in seconds). Defaults to `0.3`.
    public var duration: TimeInterval

    /// Delay of the animation (in seconds). Defaults to `0.0`.
    public var delay: TimeInterval

    /// Animation curve to apply. Defaults to `.regular(options: .curveEaseInOut)`.
    public var curve: Curve

    /// Creates animation parameters
    /// - Parameters:
    ///   - duration: duration of the animation
    ///   - delay: delay of the animation
    ///   - curve: animation curve to apply
    public init(
        duration: TimeInterval = 0.3,
        delay: TimeInterval = 0.0,
        curve: Curve = .regular(options: .curveEaseInOut)
    ) {
        self.duration = duration
        self.delay = delay
        self.curve = curve
    }
}

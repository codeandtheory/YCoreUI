//
//  UIView+Animation.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 3/31/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

/// Adds support for executing animations using properties from `Animation`
public extension UIView {
    /// Executes an animation using the specified parameters
    /// - Parameters:
    ///   - parameters: specifies duration, delay, curve type and options
    ///   - animations: the animation block to perform
    ///   - completion: the optional completion block to be called when the animation completes
    class func animate(
        with parameters: Animation,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        switch parameters.curve {
        case .regular(options: let options):
            animate(
                withDuration: parameters.duration,
                delay: parameters.delay,
                options: options,
                animations: animations,
                completion: completion
            )
        case .spring(damping: let damping, velocity: let velocity, let options):
            animate(
                withDuration: parameters.duration,
                delay: parameters.delay,
                usingSpringWithDamping: damping,
                initialSpringVelocity: velocity,
                options: options,
                animations: animations,
                completion: completion
            )
        }
    }
}

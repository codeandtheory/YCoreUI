//
//  UIView+constrainAspectRatio.swift
//  YCoreUI
//
//  Created by Dev Karan on 14/12/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import UIKit

extension UIView {
    /* Use-case examples

     // constrain to a 16:9 aspect ratio
     mediaPlayer.constrainAspectRatio(16.0 / 9)

     // constrain to a 1:1 aspect ratio
     profileImage.constrainAspectRatio(1)

     */

    /// Constrain the aspect ratio for the receiving view.
    /// - Parameters:
    ///   - ratio: aspect ratio
    ///   - offset: offset to apply (default `.zero`)
    ///   - relation: relation to evaluate (towards ratio) (default `.equal`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraint or not (default `true`)
    /// - Returns: the created layout constraint
    @discardableResult public func constrainAspectRatio(
        _ ratio: CGFloat,
        offset: CGFloat = 0,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        constrain(
            .widthAnchor,
            to: heightAnchor,
            relatedBy: relation,
            multiplier: ratio,
            constant: offset,
            priority: priority,
            isActive: isActive
        )
    }
}

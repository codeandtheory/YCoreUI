//
//  UIView+constrainCenter.swift
//  YCoreUI
//
//  Created by Dharmik Ghelani on 20/10/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import UIKit

extension UIView {
    /// Struct to define center attribute
    struct Center: OptionSet {
        let rawValue: UInt
        static let x = Center(rawValue: 1 << 0)
        static let y = Center(rawValue: 1 << 1)
        static let all: Center = [.x, .y]
    }
    
    /// Constrain the receiving view with provided center attributes
    /// - Parameters:
    ///   - center: Center attribute of view to constrain to (default `.all`)
    ///   - view2: View object to which constrain to (pass `nil` to constrain to superview)
    ///   - relation: Relation to evaluate (default `.equal`)
    ///   - offset: Offset to apply to attribute(center X and Y) (default `.zero`)
    ///   - priority: Constraint priority (default `.required`)
    ///   - isActive: Whether to activate the constraint or not (default `true`)
    /// - Returns: The created layout constraint
    func constrainCenter(
        _ center: Center = .all,
        to view2: Anchorable? = nil,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        offset: UIOffset = .zero,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> [NSLayoutConstraint.Attribute: NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint.Attribute: NSLayoutConstraint] = [:]
        let otherView: Anchorable! = view2 ?? superview
        
        if center.contains(.x) {
            constraints[.centerX] = constrain(
                .centerXAnchor,
                to: otherView.centerXAnchor,
                relatedBy: relation,
                constant: offset.horizontal,
                priority: priority,
                isActive: isActive
            )
        }
        
        if center.contains(.y) {
            constraints[.centerY] = constrain(
                .centerYAnchor,
                to: otherView.centerYAnchor,
                relatedBy: relation,
                constant: offset.vertical,
                priority: priority,
                isActive: isActive
            )
        }
        
        return constraints
    }
}

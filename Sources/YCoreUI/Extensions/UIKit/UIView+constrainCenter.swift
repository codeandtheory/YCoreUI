//
//  UIView+constrainCenter.swift
//  YCoreUI
//
//  Created by Dharmik Ghelani on 20/10/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import UIKit

extension UIView {
    /// Center alignment options
    public struct Center: OptionSet {
        /// corresponding raw value
        public let rawValue: UInt
        
        /// center X
        public static let x = Center(rawValue: 1 << 0)
        /// center Y
        public static let y = Center(rawValue: 1 << 1)
        /// all (both center X and center Y)
        public static let all: Center = [.x, .y]
        
        /// Creates the new `Center` option set from the given raw value.
        /// - Parameter rawValue: the raw value of `Center` option set to create
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
    }
    
    /// Constrain the center of the receiving view with the center of another view
    /// - Parameters:
    ///   - center: which center attributes to constrain (default `.all`)
    ///   - view2: view or layout guide to constrain to (pass `nil` to constrain to superview)
    ///   - relation: relation to evaluate (towards view2) (default `.equal`)
    ///   - offset: offset to apply relative to view2.center (default `.zero`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraints or not (default `true`)
    /// - Returns: dictionary of constraints created, keyed by `.centerX, .centerY`
    @discardableResult public func constrainCenter(
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

//
//  UIView+constrainSize.swift
//  YCoreUI
//
//  Created by Dharmik Ghelani on 17/10/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import UIKit

extension UIView {
    /* Use-case examples

     // constrain a button's size to 44 x 44 (3 different ways)
     let button = UIButton()
     addSubview(button)
     
     button.constrainSize(CGSize(width: 44, height: 44))
     button.constrainSize(width: 44, height: 44)
     button.constrainSize(44)
     
     */

    /// Constrain the receiving view with given size
    /// - Parameters:
    ///   - size: size of view to constrain to
    ///   - relation: relation to evaluate (towards size) (default `.equal`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraint or not (default `true`)
    /// - Returns: dictionary of constraints created, keyed by `.width, .height`
    @discardableResult public func constrainSize(
        _ size: CGSize,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> [NSLayoutConstraint.Attribute: NSLayoutConstraint] {
        let widthConstraint = constrain(
            .widthAnchor,
            relatedBy: relation,
            constant: size.width,
            priority: priority,
            isActive: isActive
        )
        
        let heightConstraint = constrain(
            .heightAnchor,
            relatedBy: relation,
            constant: size.height,
            priority: priority,
            isActive: isActive
        )
        
        return [.width: widthConstraint, .height: heightConstraint]
    }
    
    /// Constrain the receiving view with width and height
    /// - Parameters:
    ///   - width: width of view to constrain to
    ///   - height: height of view to constrain to
    ///   - relation: relation to evaluate (towards width and height) (default `.equal`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraint or not (default `true`)
    /// - Returns: dictionary of constraints created, keyed by `.width, .height`
    @discardableResult public func constrainSize(
        width: CGFloat,
        height: CGFloat,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> [NSLayoutConstraint.Attribute: NSLayoutConstraint] {
        constrainSize(CGSize(width: width, height: height))
    }
    
    /// Constrain the receiving view with given dimension applied to both width and height.
    /// - Parameters:
    ///   - dimension: dimension of view to constrain to
    ///   - relation: relation to evaluate (towards dimension) (default `.equal`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraint or not (default `true`)
    /// - Returns: dictionary of constraints created, keyed by `.width, .height`
    @discardableResult public func constrainSize(
        _ dimension: CGFloat,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> [NSLayoutConstraint.Attribute: NSLayoutConstraint] {
        constrainSize(CGSize(width: dimension, height: dimension))
    }
}

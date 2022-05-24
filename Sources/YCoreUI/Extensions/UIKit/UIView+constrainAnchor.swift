//
//  UIView+constrainAnchor.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 7/16/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

extension UIView {
    /* Use-case examples
     
     // constrain a button's width to 100
     let button = UIButton()
     addSubview(button)
     button.constrain(.widthAnchor, constant: 100)
     
     // constrain 2 buttons across in a view
     // hint: use constrainEdges to accomplish the same thing in fewer lines of code!
     let button1 = UIButton()
     let button2 = UIButton()
     let spacing: CGFloat = 16
     
     addSubview(button1)
     addSubview(button2)
     button1.constrain(.leadingAnchor, to: leadingAnchor, constant: spacing)
     button2.constrain(.leadingAnchor, to: button1.trailingAnchor, constant: spacing)
     button2.constrain(.trailingAnchor, to: trailingAnchor, constant: -spacing)
     button1.constrain(.widthAnchor, to: button2.widthAnchor)
     button1.constrain(.bottomAnchor, to: bottomAnchor, constant: -spacing)
     button2.constrain(.bottomAnchor, to: button1.bottomAnchor)

     // constrain view to superview
     // hint: just use container.constrainEdges() instead!
     let container = UIView()
     addSubview(container)
     container.constrain(.leadingAnchor, to: leadingAnchor)
     container.constrain(.trailingAnchor, to: trailingAnchor)
     container.constrain(.topAnchor, to: topAnchor)
     container.constrain(.bottomAnchor, to: bottomAnchor)
     
     */
    
    /// Anchors that constrain views along the x-axis
    public enum XAxisAnchor {
        /// leading anchor
        case leadingAnchor
        /// center X anchor
        case centerXAnchor
        /// trailing anchor
        case trailingAnchor
        /// leading margin anchor
        case leadingMarginAnchor
        /// center X margin anchor
        case centerXMarginAnchor
        /// trailing margin anchor
        case trailingMarginAnchor
    }
    
    /// Anchors that constrain views along the y-axis
    public enum YAxisAnchor {
        /// top anchor
        case topAnchor
        /// center Y anchor
        case centerYAnchor
        /// bottom anchor
        case bottomAnchor
        /// top margin anchor
        case topMarginAnchor
        /// center Y margin anchor
        case centerYMarginAnchor
        /// bottom margin anchor
        case bottomMarginAnchor
    }
    
    /// Anchors that constrain views along either width or height
    public enum DimensionAnchor {
        /// height anchor
        case heightAnchor
        /// width anchor
        case widthAnchor
    }
    
    /// Creates standard NSLayoutConstraint's using anchor syntax
    /// - Parameters:
    ///   - anchorType: X-axis anchor to constrain
    ///   - otherAnchor: other X-axis anchor
    ///   - relation: relation to evaluate (towards otherAnchor + c) (default `.equal`)
    ///   - c: constant offset amount (default `0`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraint or not (default `true`)
    /// - Returns: The created layout constraint
    @discardableResult public func constrain(
        _ anchorType: XAxisAnchor,
        to otherAnchor: NSLayoutXAxisAnchor,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        constant c: CGFloat = 0,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        // We will not be using autoresizing masks
        translatesAutoresizingMaskIntoConstraints = false
        
        // Extract anchor from enum
        let anchor: NSLayoutXAxisAnchor
        switch anchorType {
        case .leadingAnchor:
            anchor = leadingAnchor
        case .centerXAnchor:
            anchor = centerXAnchor
        case .trailingAnchor:
            anchor = trailingAnchor
        case .leadingMarginAnchor:
            anchor = layoutMarginsGuide.leadingAnchor
        case .centerXMarginAnchor:
            anchor = layoutMarginsGuide.centerXAnchor
        case .trailingMarginAnchor:
            anchor = layoutMarginsGuide.trailingAnchor
        }
        
        // Create the constraint
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .lessThanOrEqual:
            constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: c)
        case .greaterThanOrEqual:
            constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: c)
        case .equal:
            fallthrough
        @unknown default:
            constraint = anchor.constraint(equalTo: otherAnchor, constant: c)
        }
        
        constraint.priority = priority
        constraint.isActive = isActive
        
        return constraint
    }
    
    /// Creates standard NSLayoutConstraint's using anchor syntax
    /// - Parameters:
    ///   - anchorType: Y-axis anchor to constrain
    ///   - otherAnchor: other Y-axis anchor
    ///   - relation: relation to evaluate (towards otherAnchor + c) (default `.equal`)
    ///   - c: constant offset amount (default `0`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraint or not (default `true`)
    /// - Returns: The created layout constraint
    @discardableResult public func constrain(
        _ anchorType: YAxisAnchor,
        to otherAnchor: NSLayoutYAxisAnchor,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        constant c: CGFloat = 0,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        // We will not be using autoresizing masks
        translatesAutoresizingMaskIntoConstraints = false
        
        // Extract anchor from enum
        let anchor: NSLayoutYAxisAnchor
        switch anchorType {
        case .topAnchor:
            anchor = topAnchor
        case .centerYAnchor:
            anchor = centerYAnchor
        case .bottomAnchor:
            anchor = bottomAnchor
        case .topMarginAnchor:
            anchor = layoutMarginsGuide.topAnchor
        case .centerYMarginAnchor:
            anchor = layoutMarginsGuide.centerYAnchor
        case .bottomMarginAnchor:
            anchor = layoutMarginsGuide.bottomAnchor
        }
        
        // Create the constraint
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .lessThanOrEqual:
            constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: c)
        case .greaterThanOrEqual:
            constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: c)
        case .equal:
            fallthrough
        @unknown default:
            constraint = anchor.constraint(equalTo: otherAnchor, constant: c)
        }
        
        constraint.priority = priority
        constraint.isActive = isActive
        
        return constraint
    }
    
    /// Creates standard NSLayoutConstraint's using anchor syntax
    /// - Parameters:
    ///   - anchorType: layout dimension to constrain
    ///   - relation: relation to evaluate (towards otherAnchor + c) (default `.equal`)
    ///   - c: constant offset amount (default `0`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraint or not (default `true`)
    /// - Returns: The created layout constraint
    @discardableResult public func constrain(
        _ anchorType: DimensionAnchor,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        constant c: CGFloat,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        // We will not be using autoresizing masks
        translatesAutoresizingMaskIntoConstraints = false
        
        // Extract anchor from enum
        let anchor: NSLayoutDimension
        switch anchorType {
        case .heightAnchor:
            anchor = heightAnchor
        case .widthAnchor:
            anchor = widthAnchor
        }
        
        // Create the constraint
        let constraint: NSLayoutConstraint
        switch relation {
        case .lessThanOrEqual:
            constraint = anchor.constraint(lessThanOrEqualToConstant: c)
        case .greaterThanOrEqual:
            constraint = anchor.constraint(greaterThanOrEqualToConstant: c)
        case .equal:
            fallthrough
        @unknown default:
            constraint = anchor.constraint(equalToConstant: c)
        }
        
        constraint.priority = priority
        constraint.isActive = isActive
        
        return constraint
    }
    
    /// Creates standard NSLayoutConstraint's using anchor syntax
    /// - Parameters:
    ///   - anchorType: layout dimension to constrain
    ///   - otherAnchor: other layout dimension anchor
    ///   - relation: relation to evaluate (towards otherAnchor + c) (default `.equal`)
    ///   - multiplier: multiplier to apply (default `1`)
    ///   - c: constant offset amount (default `0`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraint or not (default `true`)
    /// - Returns: The created layout constraint
    @discardableResult public func constrain(
        _ anchorType: DimensionAnchor,
        to otherAnchor: NSLayoutDimension,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant c: CGFloat = 0,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        // We will not be using autoresizing masks
        translatesAutoresizingMaskIntoConstraints = false
        
        // Extract anchor from enum
        let anchor: NSLayoutDimension
        switch anchorType {
        case .heightAnchor:
            anchor = heightAnchor
        case .widthAnchor:
            anchor = widthAnchor
        }
        
        // Create the constraint
        let constraint: NSLayoutConstraint
        switch relation {
        case .lessThanOrEqual:
            constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor, multiplier: multiplier, constant: c)
        case .greaterThanOrEqual:
            constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, multiplier: multiplier, constant: c)
        case .equal:
            fallthrough
        @unknown default:
            constraint = anchor.constraint(equalTo: otherAnchor, multiplier: multiplier, constant: c)
        }
        
        constraint.priority = priority
        constraint.isActive = isActive
        
        return constraint
    }
 }

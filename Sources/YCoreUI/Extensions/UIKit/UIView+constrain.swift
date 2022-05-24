//
//  UIView+constrain.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 7/15/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

extension UIView {
    /* Use-case examples
     
     // constrain a button's width to 100
     let button = UIButton()
     addSubview(button)
     button.constrain(.width, constant: 100)
     
     // constrain 2 buttons across in a view
     let button1 = UIButton()
     let button2 = UIButton()
     let spacing: CGFloat = 16
     
     addSubview(button1)
     addSubview(button2)
     button1.constrain(.leading, to: .leading, of: superview, constant: spacing)
     button2.constrain(.leading, to: .trailing, of: button1, constant: spacing)
     button2.constrain(.trailing, to: .trailing, of: self, constant: -spacing)
     button1.constrain(.width, to: .width, of: button2)
     button1.constrain(.bottom, to: .bottom, of: self, constant: -spacing)
     button2.constrain(.bottom, to: .bottom, of: button1)

     // constrain view to superview
     let container = UIView()
     addSubview(container)
     container.constrain(.leading, to: .leading, of: superview)
     container.constrain(.trailing, to: .trailing, of: superview)
     container.constrain(.top, to: .top, of: superview)
     container.constrain(.bottom, to: .bottom, of: superview)
     
     */
    
    /// Declarative auto-layout. Creates standard NSLayoutConstraint's but in a
    /// declarative way and with fewer lines of code.
    /// - Parameters:
    ///   - attr1: attribute to constrain
    ///   - attr2: second attribute (optional, default `.notAnAttribute`)
    ///   - view2: view for second attribute (optional, default `nil`)
    ///   - relation: relation to evaluate (towards multiplier*attr2 + c) (default `.equal`)
    ///   - multiplier: multiplier to apply (default `1`)
    ///   - c: constant offset amount (default `0`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraint or not (default `true`)
    /// - Returns: The created layout constraint
    @discardableResult public func constrain(
        _ attr1: NSLayoutConstraint.Attribute,
        to attr2: NSLayoutConstraint.Attribute = .notAnAttribute,
        of view2: Any? = nil,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant c: CGFloat = 0,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        // We will not be using autoresizing masks
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attr1,
            relatedBy: relation,
            toItem: view2,
            attribute: attr2,
            multiplier: multiplier,
            constant: c
        )
        
        constraint.priority = priority
        constraint.isActive = isActive
        
        return constraint
    }
}

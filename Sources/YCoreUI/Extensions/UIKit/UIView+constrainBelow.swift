//
//  UIView+constrainBelow.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 12/3/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

extension UIView {
    /* Use-case examples

     // constrain 2 buttons across in a view
     let button1 = UIButton()
     let button2 = UIButton()
     let insets = NSDirectionalEdgeInsets(all: 16)
     addSubview(button1)
     addSubview(button2)

     button1.constrainEdges(.notTrailing, with: insets)
     button2.constrainEdges(.notLeading, with: insets)
     button2.constrain(after: button1, offset: insets.leading)
     button1.constrain(.widthAnchor, to: button2.widthAnchor)

     // constrain 2 labels full-width, vertically stacked in a view
     let label1 = UILabel()
     let label2 = UILabel()
     let gap: CGFloat = 16
     addSubview(label1)
     addSubview(label2)

     label1.constrainEdges(.notBottom)
     label2.constrain(below: label1, offset: gap)
     label2.constrainEdges(.notTop)

     */

    /// Constrain the receiving view below a sibling view
    /// - Parameters:
    ///   - sibling: sibling view to constrain to
    ///   - relation: relation to evaluate (towards sibling) (default `.equal`)
    ///   - offset: the gap between the bottom of sibling and the top of the receiver (default `0`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraint or not (default `true`)
    /// - Returns: The created layout constraint
    @discardableResult public func constrain(
        below sibling: Anchorable,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        offset: CGFloat = 0,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        constrain(
            .topAnchor,
            to: sibling.bottomAnchor,
            relatedBy: relation,
            constant: offset,
            priority: priority,
            isActive: isActive
        )
    }

    /// Constrain the receiving view to the left of (trailing side of) a sibling view
    /// - Parameters:
    ///   - sibling: sibling view to constrain to
    ///   - relation: relation to evaluate (towards sibling) (default `.equal`)
    ///   - offset: the gap between the trailing edge of sibling and the leading edge of the receiver (default `0`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraint or not (default `true`)
    /// - Returns: The created layout constraint
    @discardableResult public func constrain(
        after sibling: Anchorable,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        offset: CGFloat = 0,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        constrain(
            .leadingAnchor,
            to: sibling.trailingAnchor,
            relatedBy: relation,
            constant: offset,
            priority: priority,
            isActive: isActive
        )
    }
}

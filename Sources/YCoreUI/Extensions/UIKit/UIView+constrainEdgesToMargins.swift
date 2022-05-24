//
//  UIView+constrainEdgesToMargins.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 12/3/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

extension UIView {
    /* Use-case examples

     // constrain 2 buttons across in a view using margins
     let button1 = UIButton()
     let button2 = UIButton()
     let spacing: CGFloat = 16
     addSubview(button1)
     addSubview(button2)

     button1.constrainEdgesToMargins(.notTrailing)
     button2.constrainEdgesToMargins(.notLeading)
     button2.constrain(after: button1, offset: spacing)
     button1.constrain(.widthAnchor, to: button2.widthAnchor)

     // constrain view to superview margins
     let container = UIView()
     addSubview(container)
     container.constrainEdgesToMargins()

     */

    /// Inset the edges of one view to the layout margins of another view
    /// - Parameters:
    ///   - edges: which edges to constrain (default `.all`)
    ///   - view2: view whose layout margins will be used to constrain the receiver
    ///   (pass `nil` to constrain to superview.layoutMarginsGuide)
    ///   - relation: relation to evaluate (towards view2) (default `.equal`)
    ///   - insets: insets to apply to each edge (default `.zero`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraints or not (default `true`)
    /// - Returns: dictionary of constraints created, keyed by `.top, .leading, .bottom, .trailing`
    @discardableResult public func constrainEdgesToMargins(
        _ edges: NSDirectionalRectEdge = .all,
        to view2: UIView? = nil,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        with insets: NSDirectionalEdgeInsets = .zero,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> [NSLayoutConstraint.Attribute: NSLayoutConstraint] {
        let otherView = view2 ?? superview
        return constrainEdges(
            edges,
            to: otherView?.layoutMarginsGuide,
            relatedBy: relation,
            with: insets,
            priority: priority,
            isActive: isActive
        )
    }
}

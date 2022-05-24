//
//  UIView+constrainEdges.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 8/4/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

extension NSDirectionalRectEdge {
    /// Horizontal edges only (consisting of `.leading` and `.trailing`)
    public static var horizontal: NSDirectionalRectEdge { return [.leading, .trailing] }

    /// Vertical edges only (consisting of `.top` and `.bottom`)
    public static var vertical: NSDirectionalRectEdge { return [.top, .bottom] }

    /// All edges except `.top`
    public static var notTop: NSDirectionalRectEdge { return [.leading, .bottom, .trailing] }

    /// All edges except `.leading`
    public static var notLeading: NSDirectionalRectEdge { return [.top, .bottom, .trailing] }

    /// All edges except `.bottom`
    public static var notBottom: NSDirectionalRectEdge { return [.top, .leading, .trailing] }

    /// All edges except `.trailing`
    public static var notTrailing: NSDirectionalRectEdge { return [.top, .leading, .bottom] }
}

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

     // constrain view to superview
     let container = UIView()
     addSubview(container)
     container.constrainEdges()

     */

    /// Inset the edges of one view to those of another view
    /// - Parameters:
    ///   - edges: which edges to constrain (default `.all`)
    ///   - view2: view or layout guide to constrain to (pass `nil` to constrain to superview)
    ///   - relation: relation to evaluate (towards view2) (default `.equal`)
    ///   - insets: insets to apply to each edge (default `.zero`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraints or not (default `true`)
    /// - Returns: dictionary of constraints created, keyed by `.top, .leading, .bottom, .trailing`
    @discardableResult public func constrainEdges(
        _ edges: NSDirectionalRectEdge = .all,
        to view2: Anchorable? = nil,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        with insets: NSDirectionalEdgeInsets = .zero,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> [NSLayoutConstraint.Attribute: NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint.Attribute: NSLayoutConstraint] = [:]

        let otherView: Anchorable! = view2 ?? superview
        let inverseRelation = getInverseRelation(for: relation)

        if edges.contains(.top) {
            constraints[.top] = self.constrain(
                .topAnchor,
                to: otherView.topAnchor,
                relatedBy: relation,
                constant: insets.top,
                priority: priority,
                isActive: isActive
            )
        }

        if edges.contains(.leading) {
            constraints[.leading] = self.constrain(
                .leadingAnchor,
                to: otherView.leadingAnchor,
                relatedBy: relation,
                constant: insets.leading,
                priority: priority,
                isActive: isActive
            )
        }

        if edges.contains(.bottom) {
            constraints[.bottom] = self.constrain(
                .bottomAnchor,
                to: otherView.bottomAnchor,
                relatedBy: inverseRelation,
                constant: -insets.bottom,
                priority: priority,
                isActive: isActive
            )
        }

        if edges.contains(.trailing) {
            constraints[.trailing] = self.constrain(
                .trailingAnchor,
                to: otherView.trailingAnchor,
                relatedBy: inverseRelation,
                constant: -insets.trailing,
                priority: priority,
                isActive: isActive
            )
        }

        return constraints
    }

    /// Outset the edges of one view relative to those of another
    /// - Parameters:
    ///   - edges: which edges to constrain (default `.all`)
    ///   - view2: view to constraint to (pass `nil` to constrain to superview)
    ///   - relation: relation to evaluate (towards view2) (default `.equal`)
    ///   - outsets: outsets to apply to each edge (default `.zero`)
    ///   - priority: constraint priority (default `.required`)
    ///   - isActive: whether to activate the constraints or not (default `true`)
    /// - Returns: dictionary of constraints created, keyed by `.top, .leading, .bottom, .trailing`
    @discardableResult public func constrainEdges(
        _ edges: NSDirectionalRectEdge = .all,
        to view2: UIView? = nil,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        outsets: NSDirectionalEdgeInsets,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> [NSLayoutConstraint.Attribute: NSLayoutConstraint] {
        let insets = NSDirectionalEdgeInsets(
            top: -outsets.top,
            leading: -outsets.leading,
            bottom: -outsets.bottom,
            trailing: -outsets.trailing
        )
        
        return constrainEdges(
            edges,
            to: view2,
            relatedBy: relation,
            with: insets,
            priority: priority,
            isActive: isActive
        )
    }
    
    private func getInverseRelation(for relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint.Relation {
        // If we're using .lessThanOrEqual for .top and .leading, then
        // we want to use .greaterThanEqual for .bottom and .trailing
        switch relation {
        case .lessThanOrEqual:
            return .greaterThanOrEqual
        case .greaterThanOrEqual:
            return .lessThanOrEqual
        case .equal:
            fallthrough
        @unknown default:
            return relation
        }
    }
}

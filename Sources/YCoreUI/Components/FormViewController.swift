//
//  FormViewController.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 10/6/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

#if os(iOS)
/// A view controller with a scrollable content area that will automatically avoid the keyboard for you.
/// A good choice for views that have inputs (e.g. login or onboarding).
open class FormViewController: UIViewController {
    /// The top-level scrollview. Its edges are pinned to the view controller's view.
    /// Don't add subviews directly to `scrollView` but rather to `contentView` instead.
    /// This view is publicly exposed to assist with layout constraints.
    public let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()

    /// The content view. This is where you would want to add your subviews.
    /// This view is already inset from all edges so you can constrain your subviews directly to
    /// the edges without additional insets.
    public let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    /// Default vertical spacing used in the default implementation of `contentInsets` (16 points)
    public static let defaultVerticalSpacing: CGFloat = 16

    /// The content insets to apply to `contentView`.
    ///
    /// Horizontally `contentView` is pinned to the view's margins not edges,
    /// so for system default behavior you probably want to leave the horizontal values at 0.
    ///
    /// Vertically `contentView` is pinned to the top and bottom of `scrollView`, so
    /// you probably want some padding for a nice appearance.
    ///
    /// Default implementation returns `{16, 0, 16, 0}`.
    /// Override to return different insets.
    open var contentInsets: NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(topAndBottom: FormViewController.defaultVerticalSpacing, leadingAndTrailing: 0)
    }

    /// The (optional) gesture recognizer for handling taps on the scrollview outside of any controls.
    public private(set) var tapOutsideGesture: UITapGestureRecognizer?

    /// Whether to add a gesture recognizer to responds to taps on the `scrollView` (i.e. those that
    /// fall outside of the input fields) to dismiss the keyboard. If you will embed any `UIScrollView`-derived
    /// view within`contentView` (e.g. `UITableView`), then you must return `false`.
    ///
    /// Default implementation returns `true`.
    /// Override and return `false` if you don't want this behavior.
    open var useTapOutsideRecognizer: Bool {
        true
    }

    /// :nodoc:
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }

    /// Configures the various subviews. The base method configures the scroll and content views
    /// and registers to listen for keyboard notifications. Override to add additional functionality, but you
    /// will need to call `super`.
    open func configureSubviews() {
        configureScrollView()
        configureContentView()
    }

    /// Handles the tap outside gesture recognizer (see `useTapOutsideRecognizer`).
    /// Override to add custom functionality
    open func handleTapOutside() {
        view.endEditing(true)
    }
}

private extension FormViewController {
    func configureScrollView() {
        view.addSubview(scrollView)

        scrollView.constrainEdges()

        if useTapOutsideRecognizer {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutside))
            tapOutsideGesture = tapGesture
            scrollView.addGestureRecognizer(tapGesture)
        }

        scrollView.setUpFormFunctionality()
    }

    func configureContentView() {
        scrollView.addSubview(contentView)

        contentView.constrainEdgesToMargins(.horizontal, to: view, with: contentInsets)
        contentView.constrainEdges(.vertical, to: scrollView, with: contentInsets)
    }
}

// MARK: - Autolayout Helpers

public extension FormViewController {
    /// Attempts to stretch the content to fit the screen's height
    /// (but does nothing if content height already equals or exceeds screen height).
    ///
    /// This contrains `contentView`.height >= screen height.
    /// Primary use case: pin a CTA button to the bottom of the screen. To achieve this you would want to
    /// constrain the button's topAnchor to be >= previous control's bottomAnchor.
    /// Use `button.constrain(below: previousControl, relatedBy: .greaterThanOrEqual, offset: gap)`
    /// - Returns: The created height constraint
    @discardableResult
    func fitContentToScreen() -> NSLayoutConstraint {
        contentView.constrain(
            .heightAnchor,
            to: view.safeAreaLayoutGuide.heightAnchor,
            relatedBy: .greaterThanOrEqual,
            constant: -contentInsets.vertical
        )
    }

    /// Attempts to compress the content to fit the screen's height
    /// (but does nothing if content height cannot be compressed below screen height).
    ///
    /// Primary use case: a view with a resizable graphic that you would rather compress
    /// so that the entire view fits rather than have it scroll vertically.
    /// Also works when you would rather tighten up vertical spacing between elements rather than have the view scroll.
    /// In order for your layout to work in a deterministic manner, you will need to set constraints and/or
    /// compression resistance with the proper priorities.
    /// - Parameter priority: priority of compressing `contentView` to fit the screen height
    /// - Returns: The created height constraint
    @discardableResult
    func compressContentToScreen(priority: UILayoutPriority) -> NSLayoutConstraint {
        contentView.constrain(
            .heightAnchor,
            to: view.safeAreaLayoutGuide.heightAnchor,
            constant: -contentInsets.vertical,
            priority: priority
        )
    }
}

// MARK: - Gesture Handling

internal extension FormViewController {
    // Marked `internal` to allow access for unit testing
    @objc
    func didTapOutside(sender: UIGestureRecognizer) {
        handleTapOutside()
    }
}
#endif

//
//  UIScrollView+keyboardNotifications.swift
//  YCoreUI
//
//  Created by Sanjib Chakraborty on 11/10/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

extension UIScrollView {
    /// Enables form functionality (content avoids keyboard, sets interactive dismiss mode).
    /// This calls `registerKeyboardNotifications`
    /// and sets `keyboardDismissMode` to be `interactive`.
    public func setUpFormFunctionality() {
        registerKeyboardNotifications()
        keyboardDismissMode = .interactive
    }

    /// Registers the scrollview to receive keyboard notifications.
    /// These notifications will automatically be handled in `keyboardWillShow(:)` and `keyboardWillHide(:)`.
    public func registerKeyboardNotifications() {
        let center = NotificationCenter.default
        center.addObserver(
            self,
            selector: #selector(_keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        center.addObserver(
            self,
            selector: #selector(_keyboardWillShow),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        center.addObserver(
            self,
            selector: #selector(_keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    /// Called when the keyboard will show or change its frame.
    /// Adjusts `contentInset` and `scrollIndicatorInsets` to
    /// avoid the keyboard frame.
    ///
    /// Override to implement additional behavior.
    /// - Parameters:
    ///   - height: keyboard height
    ///   - duration: keyboard animation duration
    ///   - options: keyboard animation options
    open func keyboardWillShow(height: CGFloat, duration: TimeInterval, options: UIView.AnimationOptions) {
        // we want to inset the scrollview's content by the difference
        // between the keyboard's height and the safe area bottom padding (if any)
        // e.g. If keyboard height = 301 and bottomPadding = 34, then inset by 267.
        let bottomPadding = safeAreaInsets.bottom
        let bottomInset = max(height - bottomPadding, 0)
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)

        contentInset = insets
        scrollIndicatorInsets = insets
    }

    /// Called when the keyboard will hide.
    /// Adjusts `contentInset` and `scrollIndicatorInsets` back to `.zero`.
    ///
    /// Override to implement additional behavior.
    /// - Parameters:
    ///   - duration: keyboard animation duration
    ///   - options: keyboard animation options
    open func keyboardWillHide(duration: TimeInterval, options: UIView.AnimationOptions) {
        contentInset = .zero
        scrollIndicatorInsets = .zero
    }
}

// MARK: - Notification Handling

private extension UIScrollView {
    @objc
    func _keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }

        let height = keyboardHeight(from: userInfo)
        let duration = keyboardAnimationDuration(from: userInfo)
        let options = keyboardAnimationOptions(from: userInfo)
        keyboardWillShow(height: height, duration: duration, options: options)
    }

    @objc
    func _keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }

        let duration = keyboardAnimationDuration(from: userInfo)
        let options = keyboardAnimationOptions(from: userInfo)
        keyboardWillHide(duration: duration, options: options)
    }
}

// MARK: - Notification key extraction

// Marking this `internal` to expose these methods to unit testing.
// Effectively it will be `private` to those who import YCoreUI
internal extension UIScrollView {
    func keyboardHeight(from userInfo: [AnyHashable: Any]) -> CGFloat {
        guard let keyboardValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return 0
        }

        let keyboardFrame = keyboardValue.cgRectValue
        return keyboardFrame.height
    }

    func keyboardAnimationDuration(from userInfo: [AnyHashable: Any]) -> TimeInterval {
        guard let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return 0.25
        }

        return TimeInterval(animationDuration)
    }

    func keyboardAnimationOptions(from userInfo: [AnyHashable: Any]) -> UIView.AnimationOptions {
        guard let animationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else {
            return .curveEaseInOut
        }

        return UIView.AnimationOptions(rawValue: animationCurve.uintValue << 16)
    }
}

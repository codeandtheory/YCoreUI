//
//  UIScrollView+keyboardNotificationsTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 12/9/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

#if os(iOS)
final class UIScrollViewKeyboardNotificationsTests: XCTestCase {
    func testShowKeyboard() {
        let sut = makeSUT()
        let info = makeShowInfo()
        _testShowKeyboard(sut: sut, info: info)
    }

    private func _testShowKeyboard(sut: UIScrollView, info: [String: Any]) {
        // Given we show the keyboard
        postKeyboardNotification(show: true, info: info)

        // We expect the scroll view to be inset to account for the keyboard
        XCTAssertGreaterThan(sut.contentInset.bottom, 0)
    }

    func testHideKeyboard() {
        let sut = makeSUT()
        // Given we show the keyboard
        let showInfo = makeShowInfo()
        _testShowKeyboard(sut: sut, info: showInfo)

        // Then if we hide the keyboard
        let hideInfo = makeHideInfo()

        postKeyboardNotification(show: false, info: hideInfo)

        // We expect the scroll view to not be inset any more
        XCTAssertEqual(sut.contentInset, .zero)
    }

    func testBadShowKeyboardNotification() {
        let sut = makeSUT()
        // Given we post a show keyboard notification without a keyboard frame
        postKeyboardNotification(show: true, info: nil)

        // We don't expect the scroll view to be inset
        XCTAssertEqual(sut.contentInset, .zero)
    }

    func testBadHideKeyboardNotification() {
        let sut = makeSUT()
        // Given we post a show keyboard notification with a keyboard frame
        let showInfo = makeShowInfo()
        _testShowKeyboard(sut: sut, info: showInfo)

        // Then we post a hide keyboard notification without any user info
        postKeyboardNotification(show: false, info: nil)

        // We still expect the scroll view to be inset
        // (because it was not hidden)
        XCTAssertGreaterThan(sut.contentInset.bottom, 0)

        // Then if we post a hide keyboard notification with user info
        let hideInfo = makeHideInfo()
        postKeyboardNotification(show: false, info: hideInfo)
        
        // We expect the scroll view to not be inset any more
        XCTAssertEqual(sut.contentInset, .zero)
    }

    func testKeyboardHeight() {
        let sut = makeSUT()
        // Default height = 0
        XCTAssertEqual(sut.keyboardHeight(from: [:]), 0)

        // Keyboard frame rect is extracted from the dictionary and its height is returned
        let rect = CGRect(x: 0, y: 500, width: 375, height: 301)
        let info = makeUserInfo(rect: rect)
        XCTAssertEqual(
            sut.keyboardHeight(from: info),
            rect.height
        )
    }

    func testKeyboardAnimationDuration() {
        let sut = makeSUT()
        // Default duration = 0.25
        XCTAssertEqual(sut.keyboardAnimationDuration(from: [:]), 0.25)

        // Duration is extracted from the dictionary as Double and converted to TimeInterval
        let duration: TimeInterval = 0.375
        let info = makeUserInfo(duration: duration)
        XCTAssertEqual(
            sut.keyboardAnimationDuration(from: info),
            duration
        )
    }

    func testKeyboardAnimationOptions() {
        let sut = makeSUT()
        // Default options = curveEaseInOut
        XCTAssertEqual(sut.keyboardAnimationOptions(from: [:]), .curveEaseInOut)

        // let's test 4 public animation curve values
        let mappings: [UIView.AnimationCurve: UIView.AnimationOptions] = [
            .easeInOut: .curveEaseInOut,
            .easeIn: .curveEaseIn,
            .easeOut: .curveEaseOut,
            .linear: .curveLinear
        ]

        // Animation option is extracted from the dictionary as UIView.AnimationCurve
        // and converted to UIView.AnimationOptions (via << 16 operation)
        mappings.forEach { curve, options in
            let info = makeUserInfo(curve: curve)
            XCTAssertEqual(
                sut.keyboardAnimationOptions(from: info),
                options
            )
        }
    }
}

private extension UIScrollViewKeyboardNotificationsTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> UIScrollView {
        let sut = UIScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
        sut.setUpFormFunctionality()
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }

    func makeShowInfo() -> [String: Any] {
        makeUserInfo(rect: CGRect(x: 0, y: 314, width: 320, height: 254))
    }

    func makeHideInfo() -> [String: Any] {
        makeUserInfo(rect: CGRect(x: 0, y: 568, width: 320, height: 0))
    }

    func makeUserInfo(
        rect: CGRect = .zero,
        duration: Double = 0.25,
        curve: UIView.AnimationCurve = .easeInOut
    ) -> [String: Any] {
        [
            UIResponder.keyboardFrameEndUserInfoKey: NSValue(cgRect: rect),
            UIResponder.keyboardAnimationDurationUserInfoKey: duration,
            UIResponder.keyboardAnimationCurveUserInfoKey: NSNumber(value: curve.rawValue)
        ]
    }

    func postKeyboardNotification(show: Bool, info: [String: Any]?) {
        NotificationCenter.default.post(
            name: show ? UIResponder.keyboardWillShowNotification : UIResponder.keyboardWillHideNotification,
            object: nil,
            userInfo: info
        )

        // Wait for the run loop to tick (animate keyboard)
        RunLoop.current.run(until: Date())
    }
}
#endif

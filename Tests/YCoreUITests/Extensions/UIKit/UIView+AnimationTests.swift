//
//  UIView+AnimationTests.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 3/31/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class UIViewAnimationTests: XCTestCase {
    func test_regular_deliversAnimation() throws {
        defer { SpyView.reset() }
        // Given
        let duration = CGFloat(Int.random(in: 1...5)) / 10.0
        let delay = CGFloat(Int.random(in: 1...5)) / 10.0
        let options = try XCTUnwrap(getOptions().randomElement())
        let sut = Animation(
            duration: duration,
            delay: delay,
            curve: .regular(options: options)
        )
        var isAnimationBlockCalled = false
        var isCompletionBlockCalled = false

        // When
        SpyView.animate(
            with: sut
        ) {
            isAnimationBlockCalled = true
        } completion: { _ in
            isCompletionBlockCalled = true
        }

        // Then
        XCTAssertEqual(SpyView.lastAnimation, sut)
        XCTAssertTrue(isAnimationBlockCalled)
        XCTAssertTrue(isCompletionBlockCalled)
    }

    func test_spring_deliversAnimation() throws {
        defer { SpyView.reset() }
        // Given
        let duration = CGFloat(Int.random(in: 1...5)) / 10.0
        let delay = CGFloat(Int.random(in: 1...5)) / 10.0
        let options = try XCTUnwrap(getOptions().randomElement())
        let damping = CGFloat(Int.random(in: 1...10)) / 10.0
        let velocity = CGFloat(Int.random(in: 1...6)) / 10.0
        let sut = Animation(
            duration: duration,
            delay: delay,
            curve: .spring(damping: damping, velocity: velocity, options: options)
        )
        var isAnimationBlockCalled = false
        var isCompletionBlockCalled = false

        // When
        SpyView.animate(
            with: sut
        ) {
            isAnimationBlockCalled = true
        } completion: { _ in
            isCompletionBlockCalled = true
        }

        // Then
        XCTAssertEqual(SpyView.lastAnimation, sut)
        XCTAssertTrue(isAnimationBlockCalled)
        XCTAssertTrue(isCompletionBlockCalled)
    }
}

extension UIViewAnimationTests {
    func getOptions() -> [UIView.AnimationOptions] {
        [
            [],
            .curveEaseIn,
            .curveEaseInOut,
            .curveEaseOut,
            .beginFromCurrentState
        ]
    }
}

final class SpyView: UIView {
    static var lastAnimation: Animation?

    override class func animate(
        withDuration duration: TimeInterval,
        delay: TimeInterval,
        options: UIView.AnimationOptions = [],
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        lastAnimation = Animation(
            duration: duration,
            delay: delay,
            curve: .regular(options: options)
        )
        animations()
        completion?(true)
    }

    override class func animate(
        withDuration duration: TimeInterval,
        delay: TimeInterval,
        usingSpringWithDamping
        dampingRatio: CGFloat,
        initialSpringVelocity velocity: CGFloat,
        options: UIView.AnimationOptions = [],
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        lastAnimation = Animation(
            duration: duration,
            delay: delay,
            curve: .spring(damping: dampingRatio, velocity: velocity, options: options)
        )
        animations()
        completion?(true)
    }

    class func reset() {
        lastAnimation = nil
    }
}

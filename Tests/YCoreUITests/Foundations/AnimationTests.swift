//
//  AnimationTests.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 3/30/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class AnimationTests: XCTestCase {
    func test_defaults() {
        // Given
        let sut = Animation()

        // Then
        XCTAssertEqual(sut.duration, 0.3)
        XCTAssertEqual(sut.delay, 0.0)
        XCTAssertEqual(sut.curve, .regular(options: .curveEaseInOut))
    }
}

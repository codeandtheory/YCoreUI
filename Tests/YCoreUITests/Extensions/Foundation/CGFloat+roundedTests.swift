//
//  CGFloat+roundedTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 8/10/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

// Large tuples help us build unit test expectations concisely
// swiftlint:disable large_tuple

final class CGFloatRoundedTests: XCTestCase {
    typealias ScalingInputs = (
        value: CGFloat,
        scale: UIScreen.ScaleFactor,
        rounded: CGFloat,
        floored: CGFloat,
        ceiled: CGFloat
    )
    
    private let values: [ScalingInputs] = [
        (-9.9, .single, -10, -10, -9),
        (-9.9, .double, -10, -10, -9.5),
        (-9.9, .triple, -10, -10, -10 + (1 / 3.0) /* -9.667 */),
        (-1, .single, -1, -1, -1),
        (-1, .double, -1, -1, -1),
        (-1, .triple, -1, -1, -1),
        (0, .single, 0, 0, 0),
        (0, .double, 0, 0, 0),
        (0, .triple, 0, 0, 0),
        (1, .single, 1, 1, 1),
        (1, .double, 1, 1, 1),
        (1, .triple, 1, 1, 1),
        (1.1, .single, 1, 1, 2),
        (1.1, .double, 1, 1, 1.5),
        (1.1, .triple, 1, 1, 4 / 3.0 /* 1.333 */),
        (1.25, .single, 1, 1, 2),
        (1.25, .double, 1.5, 1, 1.5),
        (1.25, .triple, 4 / 3.0 /* 1.333 */, 1, 4 / 3.0 /* 1.333 */),
        (1.4, .single, 1, 1, 2),
        (1.4, .double, 1.5, 1, 1.5),
        (1.4, .triple, 4 / 3.0 /* 1.333 */, 4 / 3.0 /* 1.333 */, 5 / 3.0 /* 1.667 */),
        (1.5, .single, 2, 1, 2),
        (1.5, .double, 1.5, 1.5, 1.5),
        (1.5, .triple, 5 / 3.0 /* 1.667 */, 4 / 3.0 /* 1.333 */, 5 / 3.0 /* 1.667 */),
        (1.75, .single, 2, 1, 2),
        (1.75, .double, 2, 1.5, 2),
        (1.75, .triple, 5 / 3.0 /* 1.667 */, 5 / 3.0 /* 1.667 */, 2),
        (1.9, .single, 2, 1, 2),
        (1.9, .double, 2, 1.5, 2),
        (1.9, .triple, 2, 5 / 3.0 /* 1.667 */, 2),
        (212.5, .single, 213, 212, 213),
        (212.5, .double, 212.5, 212.5, 212.5),
        (212.5, .triple, 212 + (2 / 3.0) /* 212.667 */, 212 + (1 / 3.0) /* 212.333 */, 212 + (2 / 3.0) /* 212.667 */)
        ]

    func testRounded() {
        values.forEach {
            XCTAssertEqual($0.value.rounded(scale: $0.scale), $0.rounded)
        }
    }

    func testFloored() {
        values.forEach {
            XCTAssertEqual($0.value.floored(scale: $0.scale), $0.floored)
        }
    }

    func testCeiled() {
        values.forEach {
            XCTAssertEqual($0.value.ceiled(scale: $0.scale), $0.ceiled)
        }
    }
}

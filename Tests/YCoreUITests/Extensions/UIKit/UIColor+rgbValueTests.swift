//
//  UIColor+rgbValueTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 11/3/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest

// Large tuples help us build unit test expectations concisely
// swiftlint:disable large_tuple

final class UIColorRgbValueTests: XCTestCase {
    typealias ColorTest = (color: UIColor, prefix: String?, isUppercase: Bool, output: String)

    private let testCases: [ColorTest] = [
        (UIColor(rgb: 0x3366CC), "#", true, "#3366CC"),
        (UIColor(rgb: 0x9966CC), "#", false, "#9966cc"),
        (UIColor(rgb: 0x70b0c7), "0x", true, "0x70B0C7"),
        (UIColor(rgb: 0x70b0c7), "0x", false, "0x70b0c7"),
        (UIColor(rgb: 0x12e456), "", true, "12E456"),
        (UIColor(rgb: 0x12e456), "", false, "12e456"),
        (UIColor(rgb: 0xabad1d), nil, true, "ABAD1D"),
        (UIColor(rgb: 0xabad1d), nil, false, "abad1d"),
        (UIColor(rgb: 0xad1dea), "ab", false, "abad1dea")
        ]

    func testRgbDisplayString() {
        testCases.forEach {
            XCTAssertEqual($0.color.rgbDisplayString(prefix: $0.prefix, isUppercase: $0.isUppercase), $0.output)
        }
    }

    func testRounding() {
        // Given rgb color values that do not map perfectly to hex
        // 0.5 * 255 = 127.5. Round up to 128 => 0x80
        // 0.75 * 255 = 191.25. Round down to 191 => 0xBF
        // 0.65 * 255 = 165.75. Round up to 166 => 0xA6
        let color = UIColor(red: 0.50, green: 0.75, blue: 0.65, alpha: 1)

        // We exect each rgb color channel value to be rounded appropriately
        XCTAssertEqual(color.rgbDisplayString(), "80BFA6")
    }
}

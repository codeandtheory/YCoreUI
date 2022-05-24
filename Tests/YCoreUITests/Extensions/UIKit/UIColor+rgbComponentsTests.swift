//
//  UIColor+rgbComponentsTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 11/3/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest

final class UIColorRgbComponentsTests: XCTestCase {
    func testBlack() {
        let color = UIColor.black
        let components = color.rgbaComponents
        XCTAssertEqual(components.red, 0)
        XCTAssertEqual(components.green, 0)
        XCTAssertEqual(components.blue, 0)
        XCTAssertEqual(components.alpha, 1)
    }

    func testWhite() {
        let color = UIColor(white: 0.75, alpha: 1)
        let components = color.rgbaComponents
        XCTAssertEqual(components.red, 0.75)
        XCTAssertEqual(components.green, 0.75)
        XCTAssertEqual(components.blue, 0.75)
        XCTAssertEqual(components.alpha, 1)
    }

    func testMixed() {
        let color = UIColor(rgb: 0x996633)
        let components = color.rgbaComponents
        XCTAssertEqual(components.red, 0.6)
        XCTAssertEqual(components.green, 0.4)
        XCTAssertEqual(components.blue, 0.2)
        XCTAssertEqual(components.alpha, 1)
    }

    func testAlpha() {
        let color = UIColor.systemTeal.withAlphaComponent(0.32)
        let components = color.rgbaComponents
        XCTAssertEqual(components.alpha, 0.32)
    }
}

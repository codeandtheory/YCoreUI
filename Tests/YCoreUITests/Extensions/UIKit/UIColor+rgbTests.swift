//
//  UIColor+rgbTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 9/29/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

// 51, 102, 153, 204, 255
final class UIColorRgbTests: XCTestCase {
    func testPrimaryColors() {
        let blue = UIColor(rgb: 0x0000FF)
        let green = UIColor(rgb: 0x00FF00)
        let red = UIColor(rgb: 0xFF0000)

        XCTAssertEqual(blue, UIColor(red: 0, green: 0, blue: 1, alpha: 1))
        XCTAssertEqual(green, UIColor(red: 0, green: 1, blue: 0, alpha: 1))
        XCTAssertEqual(red, UIColor(red: 1, green: 0, blue: 0, alpha: 1))
    }

    func testIntermediateColors() {
        // Note: multiples of 51 divide relatively evenly into 255 for
        // ease of floating point comparisons in our unit tests.
        // This test iterates through 6 x 6 x 6 = 216 color combinations.
        // 0x33 corresponds to 0.2, 0x66 => 0.4, 0x99 => 0.6, etc.

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        for r: UInt in 0...5 {
            for g: UInt in 0...5 {
                for b: UInt in 0...5 {
                    let rComp = (r * 51) << 16
                    let gComp = (g * 51) << 8
                    let bComp = (b * 51)
                    let rgb = rComp + gComp + bComp
                    let color = UIColor(rgb: rgb)
                    
                    color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                    XCTAssertEqual(red, CGFloat(r) / 5.0)
                    XCTAssertEqual(green, CGFloat(g) / 5.0)
                    XCTAssertEqual(blue, CGFloat(b) / 5.0)
                    XCTAssertEqual(alpha, 1)
                }
            }
        }
    }

    func testAlpha() {
        let alphaValues: [CGFloat] = [0, 0.1, 0.25, 0.5, 0.75, 1]
        alphaValues.forEach {
            let color = UIColor(rgb: 0x336699, alpha: $0)
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            XCTAssertEqual(red, 0.2)
            XCTAssertEqual(green, 0.4)
            XCTAssertEqual(blue, 0.6)
            XCTAssertEqual(alpha, $0)
        }
    }
}

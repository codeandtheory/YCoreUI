//
//  UIColorBlendedTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 12/8/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class UIColorBlendedTests: XCTestCase {
    private let primaries: [UIColor] = [.red, .yellow, .green, .cyan, .blue, .magenta, .white, .black]

    func testLightened() {
        primaries.forEach {
            // given colors lightened by 100%
            let lightened = $0.lightened(by: 1)
            // they should be equal to white
            XCTAssertEqual(lightened, .white)
        }

        primaries.forEach {
            // given colors lightened by 0%
            let lightened = $0.lightened(by: 0)
            // they should be unmodified
            XCTAssertEqual(lightened, $0)
        }

        primaries.forEach {
            // given colors lightened by 50%
            let lightened = $0.lightened()

            let rgba0 = $0.rgbaComponents
            let rgbal = lightened.rgbaComponents

            if rgba0.red == 0 {
                XCTAssertEqual(rgbal.red, 0.50)
            } else {
                XCTAssertEqual(rgbal.red, 1)
            }

            if rgba0.green == 0 {
                XCTAssertEqual(rgbal.green, 0.50)
            } else {
                XCTAssertEqual(rgbal.green, 1)
            }

            if rgba0.blue == 0 {
                XCTAssertEqual(rgbal.blue, 0.50)
            } else {
                XCTAssertEqual(rgbal.blue, 1)
            }
        }
    }

    func testDarkened() {
        primaries.forEach {
            // given colors darkened by 100%
            let darkened = $0.darkened(by: 1)
            // they should be equal to black
            XCTAssertEqual(darkened, .black)
        }

        primaries.forEach {
            // given colors darkened by 0%
            let darkened = $0.darkened(by: 0)
            // they should be unmodified
            XCTAssertEqual(darkened, $0)
        }

        primaries.forEach {
            // given colors darkened by 25%
            let darkened = $0.darkened(by: 0.25)

            let rgba0 = $0.rgbaComponents
            let rgbad = darkened.rgbaComponents

            if rgba0.red == 1 {
                XCTAssertEqual(rgbad.red, 0.75)
            } else {
                XCTAssertEqual(rgbad.red, 0)
            }

            if rgba0.green == 1 {
                XCTAssertEqual(rgbad.green, 0.75)
            } else {
                XCTAssertEqual(rgbad.green, 0)
            }

            if rgba0.blue == 1 {
                XCTAssertEqual(rgbad.blue, 0.75)
            } else {
                XCTAssertEqual(rgbad.blue, 0)
            }
        }
    }

    func testBlended() {
        let color1 = UIColor(rgb: 0x336699)
        let color2 = UIColor(rgb: 0xCC00CC)

        let blended = color1.blended(by: 0.75, with: color2)
        let output = blended.rgbDisplayString()
        XCTAssertEqual(output, "A61ABF")
    }
}

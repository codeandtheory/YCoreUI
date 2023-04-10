//
//  UIColor+WCAGTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 12/8/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

// Large tuples help us build unit test expectations concisely
// swiftlint:disable superfluous_disable_command large_tuple

final class UIColorWCAGTests: XCTestCase {
    typealias ColorInputs = (foreground: UIColor, background: UIColor, context: WCAGContext)

    let colorPairsAA: [ColorInputs] = [
        (.contentPrimary, .backgroundPrimary, .normalText),
        (.contentPrimary, .backgroundSecondary, .normalText),
        (.contentSecondary, .backgroundSecondary, .normalText),
        (.contentLink, .backgroundSecondary, .normalText),
        (.contentPrimaryCTA, .backgroundPrimaryCTA, .normalText),
        (.contentPrimary, .backgroundPrimary, .largeText),
        (.contentPrimary, .backgroundSecondary, .largeText),
        (.contentSecondary, .backgroundSecondary, .largeText),
        (.contentLink, .backgroundSecondary, .largeText),
        (.contentPrimaryCTA, .backgroundPrimaryCTA, .largeText),
        (.contentLink, .backgroundSecondary, .uiComponent),
        (.backgroundPrimaryCTA, .backgroundSecondary, .uiComponent)
    ]

    let colorPairsAAA: [ColorInputs] = [
        (.contentPrimary, .backgroundPrimary, .normalText),
        (.contentPrimary, .backgroundSecondary, .normalText),
        (.contentSecondary, .backgroundSecondary, .normalText),
        (.contentPrimaryCTA, .backgroundPrimaryCTA, .normalText),
        (.contentPrimary, .backgroundPrimary, .largeText),
        (.contentPrimary, .backgroundSecondary, .largeText),
        (.contentSecondary, .backgroundSecondary, .largeText),
        (.contentLink, .backgroundSecondary, .largeText),
        (.contentPrimaryCTA, .backgroundPrimaryCTA, .largeText)
    ]

    func testColorContrastAA() {
        // test across all 4 color modes we support
        for traits in UITraitCollection.allColorSpaces {
            // test each color pair
            colorPairsAA.forEach {
                let color1 = $0.foreground.resolvedColor(with: traits)
                let color2 = $0.background.resolvedColor(with: traits)

                XCTAssert(
                    color1.isSufficientContrast(to: color2, context: $0.context, level: .AA),
                    String(
                        format: "#%@ %.2f vs #%@ %.2f ratio = %.02f under %@ Mode%@",
                        color1.rgbDisplayString(prefix: "#"),
                        color1.rgbaComponents.alpha,
                        color2.rgbDisplayString(prefix: "#"),
                        color2.rgbaComponents.alpha,
                        color1.contrastRatio(to: color2),
                        traits.userInterfaceStyle == .dark ? "Dark" : "Light",
                        traits.accessibilityContrast == .high ? " Increased Contrast" : ""
                    )
                )
            }
        }
    }

    func testColorContrastAAA() {
        // test across all 4 color modes we support
        for traits in UITraitCollection.allColorSpaces {
            // test each color pair
            colorPairsAAA.forEach {
                let color1 = $0.foreground.resolvedColor(with: traits)
                let color2 = $0.background.resolvedColor(with: traits)

                XCTAssert(
                    color1.isSufficientContrast(to: color2, context: $0.context, level: .AAA),
                    String(
                        format: "#%@ vs #%@ ratio = %.02f under %@ Mode%@",
                        color1.rgbDisplayString(prefix: "#"),
                        color2.rgbDisplayString(prefix: "#"),
                        color1.contrastRatio(to: color2),
                        traits.userInterfaceStyle == .dark ? "Dark" : "Light",
                        traits.accessibilityContrast == .high ? " Increased Contrast" : ""
                    )
                )
            }
        }
    }

    func testContrastFailure() {
        // 0x0093D6 has insufficient contrast to 0xFFFFFF for WCAG AA normal text (4.5 minimum)
        XCTAssertFalse(UIColor.accent.isSufficientContrast(to: .white, context: .normalText, level: .AA))
        contrastRatiosEqual(ratio1: UIColor.accent.contrastRatio(to: .white), ratio2: 3.42)

        // These light grays do not have sufficient contrast against white
        let lightGrays: [UIColor] = [.gray500, .gray600, .gray700, .gray800, .white]
        lightGrays.forEach {
            XCTAssertFalse($0.isSufficientContrast(to: .white, context: .normalText, level: .AA))
        }

        // These dark grays do not have sufficient contrast against black
        let darkGrays: [UIColor] = [.black, .copy, .gray100, .gray200, .gray300, .gray400]
        darkGrays.forEach {
            XCTAssertFalse($0.isSufficientContrast(to: .black, context: .normalText, level: .AA))
        }

        // UI component has no AAA level definition, so will always fail even for colors with high levels of contrast
        XCTAssertTrue(
            UIColor.contentPrimary.isSufficientContrast(to: .backgroundPrimary, context: .normalText, level: .AAA)
        )
        XCTAssertFalse(
            UIColor.contentPrimary.isSufficientContrast(to: .backgroundPrimary, context: .uiComponent, level: .AAA)
        )

        // Some failing colors manually computed on webaim.org/contrastchecker
        contrastRatiosEqual(ratio1: UIColor(rgb: 0x7C7575).contrastRatio(to: UIColor(rgb: 0x0A0A0A)), ratio2: 4.39)
        contrastRatiosEqual(ratio1: UIColor(rgb: 0x0A0A0A).contrastRatio(to: UIColor(rgb: 0x7C7575)), ratio2: 4.39)
    }

    func testNoContrast() {
        let colors: [UIColor] = [.red, .yellow, .green, .cyan, .blue, .magenta, .black, .white, UIColor(rgb: 0x111318)]

        // Given any color
        colors.forEach {
            // its contrast with itself is 1
            XCTAssertEqual($0.contrastRatio(to: $0), 1.0)
        }
    }

    func testMaxContrast() {
        // Given black and white
        // Their contrast with each other is 21
        XCTAssertEqual(UIColor.white.contrastRatio(to: .black), 21.0)
        XCTAssertEqual(UIColor.black.contrastRatio(to: .white), 21.0)
    }

    func test_contrastRatio_deliversRatioForOneTransparentColor() {
        let color = UIColor(rgb: 0x1B0B99)
        let color75 = color.withAlphaComponent(0.75)
        let color50 = color.withAlphaComponent(0.50)
        let color25 = color.withAlphaComponent(0.25)
        let white = UIColor.white
        let black = UIColor.black

        // contrast against white
        contrastRatiosEqual(ratio1: color.contrastRatio(to: white), ratio2: 13.51)
        contrastRatiosEqual(ratio1: color75.contrastRatio(to: white), ratio2: 7.12)
        contrastRatiosEqual(ratio1: white.contrastRatio(to: color75), ratio2: 7.12)
        contrastRatiosEqual(ratio1: color50.contrastRatio(to: white), ratio2: 3.30)
        contrastRatiosEqual(ratio1: white.contrastRatio(to: color50), ratio2: 3.30)
        contrastRatiosEqual(ratio1: color25.contrastRatio(to: white), ratio2: 1.71)
        contrastRatiosEqual(ratio1: white.contrastRatio(to: color25), ratio2: 1.71)

        // contrast against black
        contrastRatiosEqual(ratio1: color.contrastRatio(to: black), ratio2: 1.55)
        contrastRatiosEqual(ratio1: color75.contrastRatio(to: black), ratio2: 1.31)
        contrastRatiosEqual(ratio1: black.contrastRatio(to: color75), ratio2: 1.31)
        contrastRatiosEqual(ratio1: color50.contrastRatio(to: black), ratio2: 1.15)
        contrastRatiosEqual(ratio1: black.contrastRatio(to: color50), ratio2: 1.15)
        contrastRatiosEqual(ratio1: color25.contrastRatio(to: black), ratio2: 1.05)
        contrastRatiosEqual(ratio1: black.contrastRatio(to: color25), ratio2: 1.05)
    }

    func test_contrastRatio_deliversNanForTwoTransparentColors() {
        let color = UIColor(rgb: 0x1B0B99)
        let color75 = color.withAlphaComponent(0.75)
        let color50 = color.withAlphaComponent(0.50)

        XCTAssertLessThan(color75.rgbaComponents.alpha, 1.0)
        XCTAssertLessThan(color50.rgbaComponents.alpha, 1.0)
        XCTAssertTrue(color75.contrastRatio(to: color50).isNaN)
        YCoreUI.isLoggingEnabled = false
        XCTAssertTrue(color50.contrastRatio(to: color75).isNaN)
        XCTAssertFalse(color50.isSufficientContrast(to: color75))
        XCTAssertFalse(color75.isSufficientContrast(to: color50))
        YCoreUI.isLoggingEnabled = true
    }

    private func contrastRatiosEqual(ratio1: CGFloat, ratio2: CGFloat) {
        XCTAssertEqual(round(ratio1 * 100) / 100, round(ratio2 * 100) / 100)
    }
}
// swiftlint: enable large_tuple superfluous_disable_command

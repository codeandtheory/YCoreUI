//
//  ColorableTests.swift
//  YCoreUITests
//
//  Created by Panchami Shenoy on 26/10/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class ColorableTests: XCTestCase {
    func testBundle() {
        XCTAssertEqual(WarningColors.bundle, .module)
        XCTAssertEqual(ErrorColors.bundle, .module)
        XCTAssertEqual(PrimaryColors.bundle, .main)
    }

    func testNamespace() {
        XCTAssertNil(WarningColors.namespace)
        XCTAssertEqual(ErrorColors.namespace, "Error")
        XCTAssertNil(PrimaryColors.namespace)
    }

    func testFallbackColor() {
        XCTAssertEqual(WarningColors.fallbackColor, .systemPink)
        XCTAssertEqual(ErrorColors.fallbackColor, .systemPink)
        XCTAssertEqual(PrimaryColors.fallbackColor, .systemPurple)
    }

    func testLoadColorWithoutNamespace() {
        WarningColors.allCases.forEach {
            XCTAssertNotNil($0.loadColor())
        }
    }

    func testLoadColorWithNamespace() {
        ErrorColors.allCases.forEach {
            XCTAssertNotNil($0.loadColor())
        }
    }

    func testMissingColor() {
        PrimaryColors.allCases.forEach {
            XCTAssertNil($0.loadColor())
            XCTAssertEqual($0.color, PrimaryColors.fallbackColor)
        }
    }
}

private extension ColorableTests {
    enum ErrorColors: String, CaseIterable, Colorable {
        case error50
        case error100
        
        static var bundle: Bundle { .module }
        static var namespace: String? { "Error" }
    }
    
    enum WarningColors: String, CaseIterable, Colorable {
        case warning50
        case warning100
        
        static var bundle: Bundle { .module }
    }
    
    enum PrimaryColors: String, CaseIterable, Colorable {
        case primary50
        case primary100

        static var fallbackColor: UIColor { .systemPurple }
    }
}

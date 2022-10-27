//
//  String+LocalizedTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 11/4/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class StringLocalizedTests: XCTestCase {
    func testBundle() {
        XCTAssertEqual(MainBundleConstants.bundle, .main)
        XCTAssertEqual(StringConstants.bundle, .module)
    }

    func testValue() {
        StringConstants.allCases.forEach {
            // Given a localized string constant
            let string = $0.localized
            // it should not be empty
            XCTAssertFalse(string.isEmpty)
            // and it should not equal its key
            XCTAssertNotEqual($0.rawValue, string)
        }
    }
    
    func testTableName() {
        XCTAssertNil(MainBundleConstants.tableName)
        XCTAssertNil(StringConstants.tableName)
        XCTAssertEqual(SettingConstants.tableName, "Settings")
        
        SettingConstants.allCases.forEach {
            // Given a localized string constant
            let string = $0.localized
            // it should not be empty
            XCTAssertFalse(string.isEmpty)
            // and it should not equal its key
            XCTAssertNotEqual($0.rawValue, string)
        }
    }
}

enum MainBundleConstants: String, Localizable {
    case testString = "Test_String"
}

enum StringConstants: String, Localizable, CaseIterable {
    case testString = "Test_String"
    case butterfly = "Butterfly_Noun"
    case pen = "Pen_Noun"
    case ambulance = "Ambulance_Noun"

    static var bundle: Bundle { .module }
}

enum SettingConstants: String, Localizable, CaseIterable {
    case title = "Settings_Title"
    case font = "Settings_Font"
    case color = "Settings_Color"
    
    static var bundle: Bundle { .module }
    static var tableName: String? { "Settings" }
}

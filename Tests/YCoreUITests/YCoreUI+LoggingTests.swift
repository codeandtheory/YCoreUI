//
//  YCoreUI+LoggingTests.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 3/16/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class YCoreUILoggingTests: XCTestCase {
    func testDefaults() {
        XCTAssertTrue(YCoreUI.isLoggingEnabled)
    }
}

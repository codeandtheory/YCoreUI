//
//  UIEdgeInsets+directionalTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 12/8/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest

final class UIEdgeInsetsDirectionalTests: XCTestCase {
    private let testCases: [UIEdgeInsets] = [
        .zero,
        UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4),
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16),
        UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24),
        UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0),
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    ]

    func test() {
        testCases.forEach {
            let directional = $0.directionalInsets
            XCTAssertEqual($0.top, directional.top)
            XCTAssertEqual($0.left, directional.leading)
            XCTAssertEqual($0.bottom, directional.bottom)
            XCTAssertEqual($0.right, directional.trailing)
            XCTAssertEqual($0.vertical, directional.vertical)
            XCTAssertEqual($0.horizontal, directional.horizontal)
        }
    }
}

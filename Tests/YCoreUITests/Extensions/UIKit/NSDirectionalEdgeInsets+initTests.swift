//
//  NSDirectionalEdgeInsets+initTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 4/29/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class NSDirectionalEdgeInsetsInitTests: XCTestCase {
    func testAllSides() {
        let sut = makeSUT()
        sut.forEach {
            let insets = NSDirectionalEdgeInsets(all: $0)
            XCTAssertEqual(insets.top, $0)
            XCTAssertEqual(insets.leading, $0)
            XCTAssertEqual(insets.bottom, $0)
            XCTAssertEqual(insets.trailing, $0)
        }
    }

    func testHorizontalAndVertical() {
        let sut1 = makeSUT()
        let sut2 = makeSUT()
        for vertical in sut1 {
            for horizontal in sut2 {
                let insets = NSDirectionalEdgeInsets(topAndBottom: vertical, leadingAndTrailing: horizontal)
                XCTAssertEqual(insets.top, vertical)
                XCTAssertEqual(insets.leading, horizontal)
                XCTAssertEqual(insets.bottom, vertical)
                XCTAssertEqual(insets.trailing, horizontal)
            }
        }
    }

    func testVertical() {
        let sut = makeSUT()
        for vertical in sut {
            let insets = NSDirectionalEdgeInsets(topAndBottom: vertical)
            XCTAssertEqual(insets.top, vertical)
            XCTAssertEqual(insets.leading, 0)
            XCTAssertEqual(insets.bottom, vertical)
            XCTAssertEqual(insets.trailing, 0)
        }
    }

    func testHorizontal() {
        let sut = makeSUT()
        for horizontal in sut {
            let insets = NSDirectionalEdgeInsets(leadingAndTrailing: horizontal)
            XCTAssertEqual(insets.top, 0)
            XCTAssertEqual(insets.leading, horizontal)
            XCTAssertEqual(insets.bottom, 0)
            XCTAssertEqual(insets.trailing, horizontal)
        }
    }
}

private extension NSDirectionalEdgeInsetsInitTests {
    func makeSUT() -> [CGFloat] {
        [-8, 0, 2.5, 16]
    }
}

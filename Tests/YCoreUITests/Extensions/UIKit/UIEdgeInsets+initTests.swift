//
//  UIEdgeInsets+initTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 4/29/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class UIEdgeInsetsInitTests: XCTestCase {
    func testAllSides() {
        let sut = makeSUT()
        sut.forEach {
            let insets = UIEdgeInsets(all: $0)
            XCTAssertEqual(insets.top, $0)
            XCTAssertEqual(insets.left, $0)
            XCTAssertEqual(insets.bottom, $0)
            XCTAssertEqual(insets.right, $0)
        }
    }

    func testHorizontalAndVertical() {
        let sut1 = makeSUT()
        let sut2 = makeSUT()
        for vertical in sut1 {
            for horizontal in sut2 {
                let insets = UIEdgeInsets(topAndBottom: vertical, leftAndRight: horizontal)
                XCTAssertEqual(insets.top, vertical)
                XCTAssertEqual(insets.left, horizontal)
                XCTAssertEqual(insets.bottom, vertical)
                XCTAssertEqual(insets.right, horizontal)
            }
        }
    }

    func testVertical() {
        let sut = makeSUT()
        for vertical in sut {
            let insets = UIEdgeInsets(topAndBottom: vertical)
            XCTAssertEqual(insets.top, vertical)
            XCTAssertEqual(insets.left, 0)
            XCTAssertEqual(insets.bottom, vertical)
            XCTAssertEqual(insets.right, 0)
        }
    }

    func testHorizontal() {
        let sut = makeSUT()
        for horizontal in sut {
            let insets = UIEdgeInsets(leftAndRight: horizontal)
            XCTAssertEqual(insets.top, 0)
            XCTAssertEqual(insets.left, horizontal)
            XCTAssertEqual(insets.bottom, 0)
            XCTAssertEqual(insets.right, horizontal)
        }
    }
}

private extension UIEdgeInsetsInitTests {
    func makeSUT() -> [CGFloat] {
        [-8, 0, 2.5, 16]
    }
}

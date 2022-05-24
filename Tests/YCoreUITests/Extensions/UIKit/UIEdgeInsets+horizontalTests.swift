//
//  UIEdgeInsets+horizontalTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 8/11/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class UIEdgeInsetsHorizontalTests: XCTestCase {
    typealias EdgeInsetsInputs = (
        input: UIEdgeInsets,
        output: (vertical: CGFloat, horizontal: CGFloat)
    )
    
    private let values: [EdgeInsetsInputs] = [
        (.zero, (0, 0)),
        (UIEdgeInsets(top: 0.25, left: 0.25, bottom: 0.5, right: 0.5), (0.75, 0.75)),
        (UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40), (40, 60)),
        (UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15), (0, 30)),
        (UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0), (0, 15)),
        (UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15), (0, 15)),
        (UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0), (20, 0)),
        (UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), (10, 0)),
        (UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0), (10, 0)),
        (UIEdgeInsets(top: 10, left: 5, bottom: -10, right: -5), (0, 0))
    ]
    
    func testVertical() {
        values.forEach {
            XCTAssertEqual($0.input.vertical, $0.output.vertical)
        }
    }

    func testHorizontal() {
        values.forEach {
            XCTAssertEqual($0.input.horizontal, $0.output.horizontal)
        }
    }
}

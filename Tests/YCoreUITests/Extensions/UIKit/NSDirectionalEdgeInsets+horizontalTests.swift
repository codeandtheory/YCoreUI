//
//  NSDirectionalEdgeInsets+horizontalTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 8/11/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class NSDirectionalEdgeInsetsHorizontalTests: XCTestCase {
    typealias EdgeInsetsInputs = (
        input: NSDirectionalEdgeInsets,
        output: (vertical: CGFloat, horizontal: CGFloat)
    )
    
    private let values: [EdgeInsetsInputs] = [
        (.zero, (0, 0)),
        (NSDirectionalEdgeInsets(top: 0.25, leading: 0.25, bottom: 0.5, trailing: 0.5), (0.75, 0.75)),
        (NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40), (40, 60)),
        (NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15), (0, 30)),
        (NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0), (0, 15)),
        (NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15), (0, 15)),
        (NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0), (20, 0)),
        (NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0), (10, 0)),
        (NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0), (10, 0)),
        (NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: -10, trailing: -5), (0, 0))
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

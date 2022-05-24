//
//  UIView+constrainEdgesToMarginsTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 12/3/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class UIViewConstrainEdgesToMarginsTests: XCTestCase {
    func testSimple() {
        let (sut, insets) = makeSUT()
        let constraints = sut.view1.constrainEdgesToMargins(with: insets)
        let top = constraints[.top]
        let leading = constraints[.leading]
        let bottom = constraints[.bottom]
        let trailing = constraints[.trailing]

        // Exactly 4 constraints should be returned: top, leading, bottom, trailing
        XCTAssertEqual(constraints.count, 4)
        XCTAssertNotNil(top)
        XCTAssertNotNil(leading)
        XCTAssertNotNil(bottom)
        XCTAssertNotNil(trailing)

        // Each constraint should be configured as expected
        // (The insets on bottom & trailing constraints should be inverted)
        // The second item on all 4 constraints should be the superview's layout margins guide
        XCTAssertEqual(top?.firstItem as? UIView, sut.view1)
        XCTAssertEqual(top?.firstAttribute, .top)
        XCTAssertEqual(top?.secondItem as? UILayoutGuide, sut.layoutMarginsGuide)
        XCTAssertEqual(top?.secondAttribute, .top)
        XCTAssertEqual(top?.constant, insets.top)

        XCTAssertEqual(leading?.firstItem as? UIView, sut.view1)
        XCTAssertEqual(leading?.firstAttribute, .leading)
        XCTAssertEqual(leading?.secondItem as? UILayoutGuide, sut.layoutMarginsGuide)
        XCTAssertEqual(leading?.secondAttribute, .leading)
        XCTAssertEqual(leading?.constant, insets.leading)

        XCTAssertEqual(bottom?.firstItem as? UIView, sut.view1)
        XCTAssertEqual(bottom?.firstAttribute, .bottom)
        XCTAssertEqual(bottom?.secondItem as? UILayoutGuide, sut.layoutMarginsGuide)
        XCTAssertEqual(bottom?.secondAttribute, .bottom)
        XCTAssertEqual(bottom?.constant, -insets.bottom)

        XCTAssertEqual(trailing?.firstItem as? UIView, sut.view1)
        XCTAssertEqual(trailing?.firstAttribute, .trailing)
        XCTAssertEqual(trailing?.secondItem as? UILayoutGuide, sut.layoutMarginsGuide)
        XCTAssertEqual(trailing?.secondAttribute, .trailing)
        XCTAssertEqual(trailing?.constant, -insets.trailing)
    }
}

private extension UIViewConstrainEdgesToMarginsTests {
    func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (MockLayoutContainer, NSDirectionalEdgeInsets) {
        let container = MockLayoutContainer()
        let insets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 7, trailing: 11)

        trackForMemoryLeak(container, file: file, line: line)

        return (container, insets)
    }
}

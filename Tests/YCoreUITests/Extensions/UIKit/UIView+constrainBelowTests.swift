//
//  UIView+constrainBelowTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 12/3/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class UIViewConstrainBelowTests: XCTestCase {
    func testAfter() {
        let (sut, relations) = makeSUT()
        XCTAssert(sut.view1.translatesAutoresizingMaskIntoConstraints)

        for relation in relations {
            let offset = randomOffset
            let priority = randomPriority
            let isActive = randomBool

            let constraint = sut.view1.constrain(
                after: sut.view2,
                relatedBy: relation,
                offset: offset,
                priority: priority,
                isActive: isActive
            )

            XCTAssertEqual(constraint.firstItem as? UIView, sut.view1)
            XCTAssertEqual(constraint.secondItem as? UIView, sut.view2)

            XCTAssertEqual(constraint.firstAttribute, .leading)

            XCTAssertEqual(constraint.secondAttribute, .trailing)
            XCTAssertEqual(constraint.relation, relation)
            XCTAssertEqual(constraint.multiplier, 1)
            XCTAssertEqual(constraint.constant, offset)
            XCTAssertEqual(constraint.priority, priority)
            XCTAssertEqual(constraint.isActive, isActive)
        }

        // It should set translatesAutoresizingMaskIntoConstraints to false
        XCTAssertFalse(sut.view1.translatesAutoresizingMaskIntoConstraints)
    }

    func testBelow() {
        let (sut, relations) = makeSUT()
        XCTAssert(sut.view1.translatesAutoresizingMaskIntoConstraints)

        for relation in relations {
            let offset = randomOffset
            let priority = randomPriority
            let isActive = randomBool

            let constraint = sut.view1.constrain(
                below: sut.view2,
                relatedBy: relation,
                offset: offset,
                priority: priority,
                isActive: isActive
            )

            XCTAssertEqual(constraint.firstItem as? UIView, sut.view1)
            XCTAssertEqual(constraint.secondItem as? UIView, sut.view2)

            XCTAssertEqual(constraint.firstAttribute, .top)
            XCTAssertEqual(constraint.secondAttribute, .bottom)
            XCTAssertEqual(constraint.relation, relation)
            XCTAssertEqual(constraint.multiplier, 1)
            XCTAssertEqual(constraint.constant, offset)
            XCTAssertEqual(constraint.priority, priority)
            XCTAssertEqual(constraint.isActive, isActive)
        }

        // It should set translatesAutoresizingMaskIntoConstraints to false
        XCTAssertFalse(sut.view1.translatesAutoresizingMaskIntoConstraints)
    }
}

private extension UIViewConstrainBelowTests {
    func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (MockLayoutContainer, [NSLayoutConstraint.Relation]) {
        let container = MockLayoutContainer()
        let relations: [NSLayoutConstraint.Relation] = [.lessThanOrEqual, .equal, .greaterThanOrEqual]

        trackForMemoryLeak(container, file: file, line: line)

        return (container, relations)
    }

    var randomOffset: CGFloat { CGFloat.random(in: 0..<500) }

    var randomPriority: UILayoutPriority {
        UILayoutPriority(Float.random(in: 1...1000))
    }

    var randomBool: Bool { Int.random(in: 0..<2) == 0 }
}

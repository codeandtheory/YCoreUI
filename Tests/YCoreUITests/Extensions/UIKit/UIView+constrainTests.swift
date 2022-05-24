//
//  UIView+constrainTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 7/15/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class UIViewConstrainTests: XCTestCase {
    private let amount: CGFloat = 50
    private let offset: CGFloat = 10

    private let simpleAttributes: [NSLayoutConstraint.Attribute] = [
        .width,
        .height
    ]
    
    private let dualAttributes: [NSLayoutConstraint.Attribute] = [
        .width,
        .height,
        .leading,
        .trailing,
        .top,
        .bottom,
        .centerX,
        .centerY,
        .leadingMargin,
        .trailingMargin,
        .topMargin,
        .bottomMargin,
        .centerXWithinMargins,
        .centerYWithinMargins
    ]
    
    private let priorities: [UILayoutPriority] = [
        .defaultLow,
        UILayoutPriority(251),
        UILayoutPriority(749),
        .defaultHigh,
        UILayoutPriority(751),
        UILayoutPriority(999),
        .required
    ]

    func testSimpleDefaults() {
        let sut = makeSUT()
        XCTAssert(sut.translatesAutoresizingMaskIntoConstraints)
        
        simpleAttributes.forEach {
            let constraint = sut.constrain($0, constant: amount)

            XCTAssertEqual(constraint.firstItem as? UIView, sut)
            XCTAssertEqual(constraint.firstAttribute, $0)
            XCTAssertNil(constraint.secondItem)
            XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
            XCTAssertEqual(constraint.multiplier, 1)
            XCTAssertEqual(constraint.constant, amount)
            XCTAssertEqual(constraint.priority, .required)
            XCTAssert(constraint.isActive)
        }
        
        // It should set translatesAutoresizingMaskIntoConstraints to false
        XCTAssertFalse(sut.translatesAutoresizingMaskIntoConstraints)
    }

    func testInactive() {
        let sut = makeSUT()
        simpleAttributes.forEach {
            let constraint = sut.constrain($0, constant: amount, isActive: false)
            XCTAssertFalse(constraint.isActive)
        }
    }
    
    func testPriority() {
        let sut = makeSUT()
        priorities.forEach {
            let constraint = sut.constrain(.width, constant: amount, priority: $0)
            XCTAssertEqual(constraint.priority, $0)
        }
    }
    
    func testDual() {
        let sut = makeSUT()
        XCTAssert(sut.translatesAutoresizingMaskIntoConstraints)
        
        let container = UIView()
        let view2 = UIView()
        container.addSubview(sut)
        container.addSubview(view2)
        
        dualAttributes.forEach {
            let constraint = sut.constrain(
                $0,
                to: $0,
                of: view2,
                constant: offset
            )

            XCTAssertEqual(constraint.firstItem as? UIView, sut)
            XCTAssertEqual(constraint.firstAttribute, $0)
            XCTAssertEqual(constraint.secondItem as? UIView, view2)
            XCTAssertEqual(constraint.secondAttribute, $0)
            XCTAssertEqual(constraint.multiplier, 1)
            XCTAssertEqual(constraint.constant, offset)
            XCTAssertEqual(constraint.priority, .required)
            XCTAssert(constraint.isActive)
        }
        
        // It should set translatesAutoresizingMaskIntoConstraints to false
        XCTAssertFalse(sut.translatesAutoresizingMaskIntoConstraints)
    }
}

private extension UIViewConstrainTests {
    func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> UIView {
        let sut = UIView()
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
}

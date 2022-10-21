//
//  UIView+constrainCenterTests.swift
//  YCoreUI
//
//  Created by Dharmik Ghelani on 20/10/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class UIViewConstrainCenterTests: XCTestCase {
    func testCenterX() {
        let (sut, offset) = makeSUT()
        
        let constraints = sut.view1.constrainCenter(.x, offset: offset)
        let centerXConstraint = constraints[.centerX]
        
        XCTAssertFalse(sut.view1.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(constraints.count, 1)
        XCTAssertNotNil(centerXConstraint)
        XCTAssertEqual(centerXConstraint?.firstItem as? UIView, sut.view1)
        XCTAssertEqual(centerXConstraint?.firstAttribute, .centerX)
        XCTAssertEqual(centerXConstraint?.secondItem as? UIView, sut)
        XCTAssertEqual(centerXConstraint?.secondAttribute, .centerX)
        XCTAssertEqual(centerXConstraint?.constant, offset.horizontal)
    }
    
    func testCenterY() {
        let (sut, offset) = makeSUT()
        
        let constraints = sut.view1.constrainCenter(.y, offset: offset)
        let centerYConstraint = constraints[.centerY]
        
        XCTAssertFalse(sut.view1.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(constraints.count, 1)
        XCTAssertNotNil(centerYConstraint)
        XCTAssertEqual(centerYConstraint?.firstItem as? UIView, sut.view1)
        XCTAssertEqual(centerYConstraint?.firstAttribute, .centerY)
        XCTAssertEqual(centerYConstraint?.secondItem as? UIView, sut)
        XCTAssertEqual(centerYConstraint?.secondAttribute, .centerY)
        XCTAssertEqual(centerYConstraint?.constant, offset.vertical)
    }
    
    func testCenterBoth() {
        let (sut, offset) = makeSUT()
        
        let constraints = sut.view1.constrainCenter(offset: offset)
        
        let anchorAttributes: [
            (NSLayoutConstraint.Attribute, CGFloat)
        ] = [
            (.centerX, offset.horizontal),
            (.centerY, offset.vertical)
        ]
        
        XCTAssertFalse(sut.view1.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(constraints.count, 2)
        
        anchorAttributes.forEach {
            let constraint = constraints[$0.0]
            XCTAssertNotNil(constraint)
            XCTAssertEqual(constraint?.firstItem as? UIView, sut.view1)
            XCTAssertEqual(constraint?.firstAttribute, $0.0)
            XCTAssertEqual(constraint?.secondItem as? UIView, sut)
            XCTAssertEqual(constraint?.secondAttribute, $0.0)
            XCTAssertEqual(constraint?.constant, $0.1)
        }
    }
}

extension UIViewConstrainCenterTests {
    func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (MockLayoutContainer, UIOffset) {
        let container = MockLayoutContainer()
        let offset = UIOffset(horizontal: 30, vertical: 20)
        
        trackForMemoryLeak(container, file: file, line: line)
        
        return (container, offset)
    }
}

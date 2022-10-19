//
//  UIView+constrainSizeTests.swift
//  YCoreUITests
//
//  Created by Dharmik Ghelani on 17/10/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class UIViewConstrainSizeTests: XCTestCase {
    
    let randomSize = CGSize(width: 150, height: 200)
    
    func testSize() {
        let sut = makeSUT()
        
        XCTAssert(sut.translatesAutoresizingMaskIntoConstraints)
        
        let sizeAttributes: [
            (NSLayoutConstraint.Attribute, CGFloat)
        ] = [
            (.width, randomSize.width),
            (.height, randomSize.height)
        ]
        
        let constraints = sut.constrainSize(randomSize)
        
        sizeAttributes.forEach {
            guard let constraint = constraints[$0.0] else {
                XCTFail("Expected to have constraint for give attribute")
                return
            }
            
            XCTAssertEqual(constraint.firstItem as? UIView, sut)
            XCTAssertEqual(constraint.firstAttribute, $0.0)
            XCTAssertNil(constraint.secondItem)
            XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
            XCTAssertEqual(constraint.multiplier, 1)
            XCTAssertEqual(constraint.constant, $0.1)
            XCTAssertEqual(constraint.priority, .required)
            XCTAssert(constraint.isActive)
        }
    }
    
    func testWidthAndHeight() {
        let sut = makeSUT()
        
        XCTAssert(sut.translatesAutoresizingMaskIntoConstraints)
        
        let sizeAttributes: [
            (NSLayoutConstraint.Attribute, CGFloat)
        ] = [
            (.width, randomSize.width),
            (.height, randomSize.height)
        ]
        
        let constraints = sut.constrainSize(width: randomSize.width, height: randomSize.height)
        
        sizeAttributes.forEach {
            guard let constraint = constraints[$0.0] else {
                XCTFail("Expected to have constraint for give attribute")
                return
            }
            
            XCTAssertEqual(constraint.firstItem as? UIView, sut)
            XCTAssertEqual(constraint.firstAttribute, $0.0)
            XCTAssertNil(constraint.secondItem)
            XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
            XCTAssertEqual(constraint.multiplier, 1)
            XCTAssertEqual(constraint.constant, $0.1)
            XCTAssertEqual(constraint.priority, .required)
            XCTAssert(constraint.isActive)
        }
    }
    
    func testDimension() {
        let sut = makeSUT()
        
        XCTAssert(sut.translatesAutoresizingMaskIntoConstraints)
        
        let randomDimension = 100.0
        
        let sizeAttributes: [
            (NSLayoutConstraint.Attribute, CGFloat)
        ] = [
            (.width, randomDimension),
            (.height, randomDimension)
        ]
        
        let constraints = sut.constrainSize(randomDimension)
        
        sizeAttributes.forEach {
            guard let constraint = constraints[$0.0] else {
                XCTFail("Expected to have constraint for give attribute")
                return
            }
            
            XCTAssertEqual(constraint.firstItem as? UIView, sut)
            XCTAssertEqual(constraint.firstAttribute, $0.0)
            XCTAssertNil(constraint.secondItem)
            XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
            XCTAssertEqual(constraint.multiplier, 1)
            XCTAssertEqual(constraint.constant, $0.1)
            XCTAssertEqual(constraint.priority, .required)
            XCTAssert(constraint.isActive)
        }
    }
}

extension UIViewConstrainSizeTests {
    func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> UIView {
        let sut = UIView()
        
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
}

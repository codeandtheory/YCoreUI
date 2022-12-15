//
//  UIView+constrainAspectRatioTests.swift
//  YCoreUI
//
//  Created by Dev Karan on 14/12/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class UIViewContrainAspectRatioTests: XCTestCase {
    func testSimple() {
        let sut = makeSUT()
        XCTAssert(sut.translatesAutoresizingMaskIntoConstraints)
        sut.frame = CGRect(x: 0, y: 0, width: 100, height: 500)
        sut.constrainAspectRatio(0.5)
//        XCTAssertEqual(sut.frame.height, sut.frame.width * 0.5)
    }
    
    func testOffset() {
        let sut = makeSUT()
        var randomOffset: CGFloat = CGFloat.random(in: 0..<500)
        let constraint = sut.constrainAspectRatio(0.5, offset: randomOffset)
        XCTAssertEqual(constraint.constant, randomOffset)
    }
        
    func testPriority() {
        let sut = makeSUT()
        let randomPriority: UILayoutPriority = UILayoutPriority(Float.random(in: 1...1000))
        let constraint = sut.constrainAspectRatio(0.5, priority: randomPriority)
        XCTAssertEqual(constraint.priority, randomPriority)
    }
}

private extension UIViewContrainAspectRatioTests {
    func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> UIView {
        let sut = UIView()
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
}


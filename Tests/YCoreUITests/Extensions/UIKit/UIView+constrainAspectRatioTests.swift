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
    func test_constrainAspectRatio_deliversDefaultValues() {
        // Arrange
        let sut = makeSUT()
        // Act
        let constraint = sut.constrainAspectRatio(0.5)
        // Assert
        XCTAssertEqual(constraint.constant, .zero)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .height)
    }
    
    func test_constrainAspectRatio_translatesAutoresizingMaskIntoConstraintsIsFalse() {
        // Arrange
        let sut = makeSUT()
        // Act
        sut.constrainAspectRatio(0.5)
        // Assert
        XCTAssertFalse(sut.translatesAutoresizingMaskIntoConstraints)
    }
    
    func test_constrainAspectRatio_multiplierAndRatioMatches() {
        // Arrange
        let sut = makeSUT()
        let ratio = 0.5
        // Act
        let constraint = sut.constrainAspectRatio(ratio)
        // Assert
        XCTAssertEqual(constraint.multiplier, ratio)
    }
    
    func test_constrainAspectRatio_resizesSUTWithGivenRatio() {
        // Arrange
        let containerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 500, height: 500)))
        let sut = makeSUT()
        containerView.addSubview(sut)
        
        let ratio: CGFloat = 0.7
        let height: CGFloat = 300
        sut.constrain(.heightAnchor, constant: height)
        // Act
        sut.constrainAspectRatio(ratio)
        sut.layoutIfNeeded()
        // Assert
        XCTAssertEqual(sut.bounds.width, ratio * sut.bounds.height)
        XCTAssertEqual(sut.bounds.height, height)
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

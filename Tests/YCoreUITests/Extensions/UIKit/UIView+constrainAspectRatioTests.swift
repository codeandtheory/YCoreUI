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
    
    func test_constrainAspectRatio_translatesAutoResizingMaskIsFalse() {
        // Arrange
        let sut = makeSUT()
        // Act
        sut.constrainAspectRatio(0.5)
        // Assert
        XCTAssertFalse(sut.translatesAutoresizingMaskIntoConstraints)
    }
    
    func test_constrainAspectRatio_deliversMultiplierForTheGivenRatio() {
        // Arrange
        let sut = makeSUT()
        // Act
        let constraint = sut.constrainAspectRatio(0.5)
        // Assert
        XCTAssertEqual(constraint.multiplier, 0.5)
    }
    
//    func test_constrainAspectRatio_layoutsSUT() {
//        // Arrange
//        let containerView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//
//        containerView.heightAnchor.constraint(equalToConstant: 500).isActive = true
//        containerView.widthAnchor.constraint(equalToConstant: 500).isActive = true
//
//        containerView.layoutIfNeeded()
//
//
//
//        let sut = makeSUT()
//
//        // Act
//        sut.constrainAspectRatio(0.5)
//
//        sut.layoutIfNeeded()
//
//
//
//        XCTAssertEqual(sut.frame.height, sut.frame.width * 0.5)
//    }
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


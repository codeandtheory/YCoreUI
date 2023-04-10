//
//  UIView+constrainAnchorTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 7/16/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

// swiftlint:disable superfluous_disable_command type_body_length

final class UIViewConstrainAnchorTests: XCTestCase {
    func testXAxisConstraints() {
        let (sut, relations) = makeSUT()
        let xAxisAttributes: [(UIView.XAxisAnchor, NSLayoutXAxisAnchor)] = [
            (.leadingAnchor, sut.view2.leadingAnchor),
            (.centerXAnchor, sut.view2.centerXAnchor),
            (.trailingAnchor, sut.view2.trailingAnchor)
        ]

        XCTAssert(sut.view1.translatesAutoresizingMaskIntoConstraints)
        
        xAxisAttributes.forEach {
            for relation in relations {
                let offset = randomOffset
                let priority = randomPriority
                let isActive = randomBool
                
                let constraint = sut.view1.constrain(
                    $0.0,
                    to: $0.1,
                    relatedBy: relation,
                    constant: offset,
                    priority: priority,
                    isActive: isActive
                )
                
                XCTAssertEqual(constraint.firstItem as? UIView, sut.view1)
                XCTAssertEqual(constraint.secondItem as? UIView, sut.view2)
                
                switch $0.0 {
                case .leadingAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .leading)
                    
                case .centerXAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .centerX)
                case .trailingAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .trailing)
                default:
                    XCTAssert(false, "Unexpected anchor type for this test")
                }
                
                XCTAssertEqual(constraint.firstAttribute, constraint.secondAttribute)
                XCTAssertEqual(constraint.relation, relation)
                XCTAssertEqual(constraint.multiplier, 1)
                XCTAssertEqual(constraint.constant, offset)
                XCTAssertEqual(constraint.priority, priority)
                XCTAssertEqual(constraint.isActive, isActive)
            }
        }
        
        // It should set translatesAutoresizingMaskIntoConstraints to false
        XCTAssertFalse(sut.view1.translatesAutoresizingMaskIntoConstraints)
    }

    func testXAxisMarginConstraints() {
        let (sut, relations) = makeSUT()
        let xAxisAttributes: [(UIView.XAxisAnchor, NSLayoutXAxisAnchor)] = [
            (.leadingMarginAnchor, sut.view2.layoutMarginsGuide.leadingAnchor),
            (.centerXMarginAnchor, sut.view2.layoutMarginsGuide.centerXAnchor),
            (.trailingMarginAnchor, sut.view2.layoutMarginsGuide.trailingAnchor)
        ]

        XCTAssert(sut.view1.translatesAutoresizingMaskIntoConstraints)
        
        xAxisAttributes.forEach {
            for relation in relations {
                let offset = randomOffset
                let priority = randomPriority
                let isActive = randomBool
                
                let constraint = sut.view1.constrain(
                    $0.0,
                    to: $0.1,
                    relatedBy: relation,
                    constant: offset,
                    priority: priority,
                    isActive: isActive
                )
                
                XCTAssertEqual(constraint.firstItem as? UILayoutGuide, sut.view1.layoutMarginsGuide)
                XCTAssertEqual(constraint.secondItem as? UILayoutGuide, sut.view2.layoutMarginsGuide)
                
                switch $0.0 {
                case .leadingMarginAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .leading)
                case .centerXMarginAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .centerX)
                case .trailingMarginAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .trailing)
                default:
                    XCTAssert(false, "Unexpected anchor type for this test")
                }
                
                XCTAssertEqual(constraint.firstAttribute, constraint.secondAttribute)
                XCTAssertEqual(constraint.relation, relation)
                XCTAssertEqual(constraint.multiplier, 1)
                XCTAssertEqual(constraint.constant, offset)
                XCTAssertEqual(constraint.priority, priority)
                XCTAssertEqual(constraint.isActive, isActive)
            }
        }
        
        // It should set translatesAutoresizingMaskIntoConstraints to false
        XCTAssertFalse(sut.view1.translatesAutoresizingMaskIntoConstraints)
    }

    func testYAxisConstraints() {
        let (sut, relations) = makeSUT()
        let yAxisAttributes: [(UIView.YAxisAnchor, NSLayoutYAxisAnchor)] = [
            (.topAnchor, sut.view2.topAnchor),
            (.centerYAnchor, sut.view2.centerYAnchor),
            (.bottomAnchor, sut.view2.bottomAnchor)
        ]

        XCTAssert(sut.view1.translatesAutoresizingMaskIntoConstraints)
        
        yAxisAttributes.forEach {
            for relation in relations {
                let offset = randomOffset
                let priority = randomPriority
                let isActive = randomBool
                
                let constraint = sut.view1.constrain(
                    $0.0,
                    to: $0.1,
                    relatedBy: relation,
                    constant: offset,
                    priority: priority,
                    isActive: isActive
                )
                
                XCTAssertEqual(constraint.firstItem as? UIView, sut.view1)
                XCTAssertEqual(constraint.secondItem as? UIView, sut.view2)
                
                switch $0.0 {
                case .topAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .top)
                case .centerYAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .centerY)
                case .bottomAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .bottom)
                default:
                    XCTAssert(false, "Unexpected anchor type for this test")
                }
                
                XCTAssertEqual(constraint.firstAttribute, constraint.secondAttribute)
                XCTAssertEqual(constraint.relation, relation)
                XCTAssertEqual(constraint.multiplier, 1)
                XCTAssertEqual(constraint.constant, offset)
                XCTAssertEqual(constraint.priority, priority)
                XCTAssertEqual(constraint.isActive, isActive)
            }
        }
        
        // It should set translatesAutoresizingMaskIntoConstraints to false
        XCTAssertFalse(sut.view1.translatesAutoresizingMaskIntoConstraints)
    }

    func testYAxisMarginConstraints() {
        let (sut, relations) = makeSUT()
        let yAxisAttributes: [(UIView.YAxisAnchor, NSLayoutYAxisAnchor)] = [
            (.topMarginAnchor, sut.view2.layoutMarginsGuide.topAnchor),
            (.centerYMarginAnchor, sut.view2.layoutMarginsGuide.centerYAnchor),
            (.bottomMarginAnchor, sut.view2.layoutMarginsGuide.bottomAnchor)
        ]

        XCTAssert(sut.view1.translatesAutoresizingMaskIntoConstraints)
        
        yAxisAttributes.forEach {
            for relation in relations {
                let offset = randomOffset
                let priority = randomPriority
                let isActive = randomBool
                
                let constraint = sut.view1.constrain(
                    $0.0,
                    to: $0.1,
                    relatedBy: relation,
                    constant: offset,
                    priority: priority,
                    isActive: isActive
                )
                
                XCTAssertEqual(constraint.firstItem as? UILayoutGuide, sut.view1.layoutMarginsGuide)
                XCTAssertEqual(constraint.secondItem as? UILayoutGuide, sut.view2.layoutMarginsGuide)
                
                switch $0.0 {
                case .topMarginAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .top)
                case .centerYMarginAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .centerY)
                case .bottomMarginAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .bottom)
                default:
                    XCTAssert(false, "Unexpected anchor type for this test")
                }
                
                XCTAssertEqual(constraint.firstAttribute, constraint.secondAttribute)
                XCTAssertEqual(constraint.relation, relation)
                XCTAssertEqual(constraint.multiplier, 1)
                XCTAssertEqual(constraint.constant, offset)
                XCTAssertEqual(constraint.priority, priority)
                XCTAssertEqual(constraint.isActive, isActive)
            }
        }
        
        // It should set translatesAutoresizingMaskIntoConstraints to false
        XCTAssertFalse(sut.view1.translatesAutoresizingMaskIntoConstraints)
    }

    func testSimpleLayoutDimensions() {
        let (sut, relations) = makeSUT()
        let layoutDimensions: [UIView.DimensionAnchor] = [.heightAnchor, .widthAnchor]

        XCTAssert(sut.view1.translatesAutoresizingMaskIntoConstraints)
        
        layoutDimensions.forEach {
            for relation in relations {
                let dimension = randomOffset
                let priority = randomPriority
                let isActive = randomBool
                
                let constraint = sut.view1.constrain(
                    $0,
                    relatedBy: relation,
                    constant: dimension,
                    priority: priority,
                    isActive: isActive
                )
                
                XCTAssertEqual(constraint.firstItem as? UIView, sut.view1)
                XCTAssertNil(constraint.secondItem as? UIView)
                
                switch $0 {
                case .heightAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .height)
                case .widthAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .width)
                }
                
                XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
                XCTAssertEqual(constraint.relation, relation)
                XCTAssertEqual(constraint.multiplier, 1)
                XCTAssertEqual(constraint.constant, dimension)
                XCTAssertEqual(constraint.priority, priority)
                XCTAssertEqual(constraint.isActive, isActive)
            }
        }
        
        // It should set translatesAutoresizingMaskIntoConstraints to false
        XCTAssertFalse(sut.view1.translatesAutoresizingMaskIntoConstraints)
    }

    func testLayoutDimensions() {
        let (sut, relations) = makeSUT()
        let layoutAttributes: [(UIView.DimensionAnchor, NSLayoutDimension)] = [
            // constrain to superview
            (.heightAnchor, sut.heightAnchor),
            (.widthAnchor, sut.widthAnchor),
            // constrain to sibling view
            (.heightAnchor, sut.view2.heightAnchor),
            (.widthAnchor, sut.view2.widthAnchor),
            // constrain to self
            (.heightAnchor, sut.view1.widthAnchor),
            (.widthAnchor, sut.view1.heightAnchor)
        ]

        XCTAssert(sut.view1.translatesAutoresizingMaskIntoConstraints)
        
        layoutAttributes.forEach {
            for relation in relations {
                let multiplier = randomMultiplier
                let offset = randomOffset
                let priority = randomPriority
                let isActive = randomBool
                
                let constraint = sut.view1.constrain(
                    $0.0,
                    to: $0.1,
                    relatedBy: relation,
                    multiplier: multiplier,
                    constant: offset,
                    priority: priority,
                    isActive: isActive
                )
                
                XCTAssertEqual(constraint.firstItem as? UIView, sut.view1)
                XCTAssertNotNil(constraint.secondItem)
                
                switch $0.0 {
                case .heightAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .height)
                case .widthAnchor:
                    XCTAssertEqual(constraint.firstAttribute, .width)
                }
                
                XCTAssert(constraint.secondAttribute == .height || constraint.secondAttribute == .width)
                XCTAssertEqual(constraint.relation, relation)
                XCTAssertEqual(constraint.multiplier, multiplier)
                XCTAssertEqual(constraint.constant, offset)
                XCTAssertEqual(constraint.priority, priority)
                XCTAssertEqual(constraint.isActive, isActive)
            }
        }
        
        // It should set translatesAutoresizingMaskIntoConstraints to false
        XCTAssertFalse(sut.view1.translatesAutoresizingMaskIntoConstraints)
    }
}

private extension UIViewConstrainAnchorTests {
    func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (MockLayoutContainer, [NSLayoutConstraint.Relation]) {
        let container = MockLayoutContainer()
        let relations: [NSLayoutConstraint.Relation] = [.lessThanOrEqual, .equal, .greaterThanOrEqual]

        trackForMemoryLeak(container, file: file, line: line)

        return (container, relations)
    }

    var randomMultiplier: CGFloat {
        switch Int.random(in: 0...7) {
        case 0: return 0.25
        case 1: return 0.50
        case 2: return 0.75
        case 3: return 1.00
        case 4: return 1.25
        case 5: return 1.50
        case 6: return 1.75
        case 7: return 2.00
        default:
            XCTFail("Unexpected modulo 8 result")
            return 1.00
        }
    }
    
    var randomOffset: CGFloat { CGFloat.random(in: 0..<500) }

    var randomPriority: UILayoutPriority {
        UILayoutPriority(Float.random(in: 1...1000))
    }
    
    var randomBool: Bool { Int.random(in: 0..<2) == 0 }
}

final class MockLayoutContainer: UIView {
    let view1 = UIView()
    let view2 = UIView()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

private extension MockLayoutContainer {
    func setup() {
        addSubview(view1)
        addSubview(view2)
    }
}
// swiftlint:enable superfluous_disable_command type_body_length

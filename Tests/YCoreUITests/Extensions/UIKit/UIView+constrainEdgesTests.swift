//
//  UIView+constrainEdgesTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 8/4/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest

final class UIViewConstrainEdgesTests: XCTestCase {
    func testSimple() {
        let (sut, insets) = makeSUT()
        let constraints = sut.view1.constrainEdges(with: insets)
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
        XCTAssertEqual(top?.firstItem as? UIView, sut.view1)
        XCTAssertEqual(top?.firstAttribute, .top)
        XCTAssertEqual(top?.secondItem as? UIView, sut)
        XCTAssertEqual(top?.secondAttribute, .top)
        XCTAssertEqual(top?.constant, insets.top)
        
        XCTAssertEqual(leading?.firstItem as? UIView, sut.view1)
        XCTAssertEqual(leading?.firstAttribute, .leading)
        XCTAssertEqual(leading?.secondItem as? UIView, sut)
        XCTAssertEqual(leading?.secondAttribute, .leading)
        XCTAssertEqual(leading?.constant, insets.leading)
        
        XCTAssertEqual(bottom?.firstItem as? UIView, sut.view1)
        XCTAssertEqual(bottom?.firstAttribute, .bottom)
        XCTAssertEqual(bottom?.secondItem as? UIView, sut)
        XCTAssertEqual(bottom?.secondAttribute, .bottom)
        XCTAssertEqual(bottom?.constant, -insets.bottom)
        
        XCTAssertEqual(trailing?.firstItem as? UIView, sut.view1)
        XCTAssertEqual(trailing?.firstAttribute, .trailing)
        XCTAssertEqual(trailing?.secondItem as? UIView, sut)
        XCTAssertEqual(trailing?.secondAttribute, .trailing)
        XCTAssertEqual(trailing?.constant, -insets.trailing)
    }
    func testPartialEdges() {
        let (sut, _) = makeSUT()
        let edges: [NSDirectionalRectEdge] = [
            .top,
            .leading,
            .bottom,
            .trailing,
            .all,
            .horizontal,
            .vertical,
            .notTop,
            .notLeading,
            .notBottom,
            .notTrailing
        ]
        
        let button = UIButton()
        
        edges.forEach {
            sut.addSubview(button)
            
            let constraints = button.constrainEdges($0)
            let top = constraints[.top]
            let leading = constraints[.leading]
            let bottom = constraints[.bottom]
            let trailing = constraints[.trailing]

            // The constraints returned should exactly match the edges requested
            var count = 0
            
            if $0.contains(.top) {
                XCTAssertNotNil(top)
                count += 1
            } else {
                XCTAssertNil(top)
            }
            
            if $0.contains(.leading) {
                XCTAssertNotNil(leading)
                count += 1
            } else {
                XCTAssertNil(leading)
            }
            
            if $0.contains(.bottom) {
                XCTAssertNotNil(bottom)
                count += 1
            } else {
                XCTAssertNil(bottom)
            }
            
            if $0.contains(.trailing) {
                XCTAssertNotNil(trailing)
                count += 1
            } else {
                XCTAssertNil(trailing)
            }

            XCTAssertEqual(constraints.count, count)
            
            button.removeFromSuperview()
        }
    }
    
    func testRelation() {
        let (sut, _) = makeSUT()
        let relations: [(input: NSLayoutConstraint.Relation, inverse: NSLayoutConstraint.Relation)] = [
            (.equal, .equal),
            (.lessThanOrEqual, .greaterThanOrEqual),
            (.greaterThanOrEqual, .lessThanOrEqual)
        ]
        
        let button = UIButton()
        
        relations.forEach {
            sut.addSubview(button)
            
            let constraints = button.constrainEdges(relatedBy: $0.input)
            let top = constraints[.top]
            let leading = constraints[.leading]
            let bottom = constraints[.bottom]
            let trailing = constraints[.trailing]

            // top & leading should use the specified relation
            XCTAssertEqual(top?.relation, $0.input)
            XCTAssertEqual(leading?.relation, $0.input)
            
            // bottom & trailing should use the inverse relation
            XCTAssertEqual(bottom?.relation, $0.inverse)
            XCTAssertEqual(trailing?.relation, $0.inverse)
            
            button.removeFromSuperview()
        }
    }
    
    func testOutsets() {
        let (sut, _) = makeSUT()
        let outsets = NSDirectionalEdgeInsets(top: -2, leading: -3, bottom: -7, trailing: -11)
        let constraints = sut.view1.constrainEdges(outsets: outsets)
        
        let top = constraints[.top]
        let leading = constraints[.leading]
        let bottom = constraints[.bottom]
        let trailing = constraints[.trailing]
        
        XCTAssertEqual(top?.constant, -outsets.top)
        XCTAssertEqual(leading?.constant, -outsets.leading)
        XCTAssertEqual(bottom?.constant, outsets.bottom)
        XCTAssertEqual(trailing?.constant, outsets.trailing)
    }
}

private extension UIViewConstrainEdgesTests {
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

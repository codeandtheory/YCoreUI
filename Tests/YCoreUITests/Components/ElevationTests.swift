//
//  ElevationTests.swift
//  YCoreUITests
//
//  Created by Karthik K Manoj on 14/12/22.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

struct Elevation {
    let offset: CGSize
    let blur: CGFloat
    let spread: CGFloat
    let color: UIColor
    let opacity: CGFloat
    let useShadowPath: Bool
    
    init(
        offset: CGSize,
        blur: CGFloat,
        spread: CGFloat,
        color: UIColor,
        opacity: CGFloat,
        useShadowPath: Bool = true
    ) {
        self.offset = offset
        self.blur = blur
        self.spread = spread
        self.color = color
        self.opacity = opacity
        self.useShadowPath = useShadowPath
    }
    
    func apply(layer: CALayer) {
        guard useShadowPath else { return }
        
        layer.shadowPath = UIBezierPath().cgPath
    }
}

final class ElevationTests: XCTestCase {
    func test_init_deliversGivenValues() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.offset, CGSize(width: 1, height: 1))
        XCTAssertEqual(sut.blur, 2)
        XCTAssertEqual(sut.spread, 3)
        XCTAssertEqual(sut.color, .red)
        XCTAssertEqual(sut.opacity, 5)
        XCTAssertEqual(sut.useShadowPath, true)
    }
    
    func test_init_defaultValue() {
        let sut = Elevation(
            offset: CGSize(width: 1, height: 1),
            blur: 2,
            spread: 3,
            color: .red,
            opacity: 5
        )
        
        XCTAssertEqual(sut.useShadowPath, true)
    }
    
    func test_apply_doesNotAddShadowPathWhenUseShadowPathIsFalse() {
        let sut = makeSUT(useShadowPath: false)
        
        let layer = CALayer()
        
        sut.apply(layer: layer)
        
        XCTAssertNil(layer.shadowPath)
    }
    
    func test_apply_addsShadowPathWhenUseShadowPathIsTrue() {
        let sut = makeSUT(useShadowPath: true)
        
        let layer = CALayer()
        
        sut.apply(layer: layer)
        
        XCTAssertNotNil(layer.shadowPath)
    }
    
    func makeSUT(offset: CGSize = CGSize(width: 1, height: 1),
                 blur: CGFloat = 2,
                 spread: CGFloat = 3,
                 color: UIColor = .red,
                 opacity: CGFloat = 5,
                 useShadowPath: Bool = true
    ) -> Elevation {
        Elevation(
            offset: offset,
            blur: blur,
            spread: spread,
            color: color,
            opacity: opacity,
            useShadowPath: useShadowPath
        )
    }
}

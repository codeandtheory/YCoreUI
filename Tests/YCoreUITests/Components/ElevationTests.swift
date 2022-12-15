//
//  ElevationTests.swift
//  YCoreUITests
//
//  Created by Karthik K Manoj on 14/12/22.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
import YCoreUI

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
        
        sut.apply(layer: layer, cornerRadius: 8)
        
        XCTAssertNil(layer.shadowPath)
    }
    
    func test_apply_addsShadowPathWhenUseShadowPathIsTrue() {
        let sut = makeSUT(useShadowPath: true)
        
        let layer = CALayer()
        
        sut.apply(layer: layer, cornerRadius: 8)
        
        XCTAssertNotNil(layer.shadowPath)
    }
}

private extension ElevationTests {
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

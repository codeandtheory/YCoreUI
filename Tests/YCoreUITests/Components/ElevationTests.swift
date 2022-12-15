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
        
        XCTAssertEqual(sut.xOffset, 1)
        XCTAssertEqual(sut.yOffset, 1)
        XCTAssertEqual(sut.blur, 2)
        XCTAssertEqual(sut.spread, 3)
        XCTAssertEqual(sut.color, .red)
        XCTAssertEqual(sut.opacity, 0.5)
        XCTAssertEqual(sut.useShadowPath, true)
    }

    func test_init_defaultValue() {
        let sut = Elevation(
            xOffset: 1,
            yOffset: 1,
            blur: 2,
            spread: 3,
            color: .red,
            opacity: 5
        )

        XCTAssertEqual(sut.useShadowPath, true)
    }

    func test_init_negativeBlur() {
        let sut = makeSUT(blur: -10)

        XCTAssertEqual(sut.blur, 0)
    }

    func test_init_negativeOpacity() {
        let sut = makeSUT(opacity: -1)

        XCTAssertEqual(sut.opacity, 0)
    }

    func test_init_tooLargeOpacity() {
        let sut = makeSUT(opacity: 5)

        XCTAssertEqual(sut.opacity, 1)
    }

    func test_apply_doesNotSetShadowPathWhenUseShadowPathIsFalse() {
        let sut = makeSUT(useShadowPath: false)
        let layer = makeLayer()
        
        sut.apply(layer: layer)
        
        XCTAssertNil(layer.shadowPath)
    }
    
    func test_apply_setsShadowPathWhenUseShadowPathIsTrue() {
        let sut = makeSUT(useShadowPath: true)
        let layer = makeLayer()

        sut.apply(layer: layer)

        XCTAssertNotNil(layer.shadowPath)
    }

    func test_apply_usesLayerRadiusWhenCornerRadiusIsNil() {
        let sut = makeSUT(xOffset: 0, yOffset: 0, spread: 0, useShadowPath: true)
        let layer = makeLayer(cornerRadius: 4)

        sut.apply(layer: layer)

        XCTAssertEqual(layer.shadowPath, UIBezierPath(roundedRect: layer.bounds, cornerRadius: 4).cgPath)
    }

    func test_apply_usesCornerRadiusWhenNotNil() {
        let sut = makeSUT(xOffset: 0, yOffset: 0, spread: 0, useShadowPath: true)
        let layer = makeLayer(cornerRadius: 4)

        sut.apply(layer: layer, cornerRadius: 6)

        XCTAssertEqual(layer.shadowPath, UIBezierPath(roundedRect: layer.bounds, cornerRadius: 6).cgPath)
    }

    func test_apply_combinesRadiusAndSpread() {
        let spread: CGFloat = 8
        let radius: CGFloat = 4
        let sut = makeSUT(xOffset: 0, yOffset: 0, spread: spread, useShadowPath: true)
        let layer = makeLayer(cornerRadius: radius)

        sut.apply(layer: layer)

        let rect = layer.bounds.insetBy(dx: -spread, dy: -spread)
        XCTAssertEqual(layer.shadowPath, UIBezierPath(roundedRect: rect, cornerRadius: radius + spread).cgPath)
    }

    func test_apply_floorsRadiusAndSpreadToZero() {
        let spread: CGFloat = -8
        let radius: CGFloat = 4
        let sut = makeSUT(xOffset: 0, yOffset: 0, spread: spread, useShadowPath: true)
        let layer = makeLayer(cornerRadius: radius)

        sut.apply(layer: layer)

        let rect = layer.bounds.insetBy(dx: -spread, dy: -spread)
        XCTAssertEqual(layer.shadowPath, UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath)
    }

    func test_apply_setsShadowPropertiesWhenUseShadowPathIsFalse() {
        let sut = makeSUT(useShadowPath: false)
        let layer = makeLayer()
        
        sut.apply(layer: layer)
        
        XCTAssertEqual(layer.shadowOffset, CGSize(width: 1, height: 1))
        XCTAssertEqual(layer.shadowColor, UIColor.red.cgColor)
        XCTAssertEqual(layer.shadowOpacity, 0.5)
        XCTAssertEqual(layer.shadowRadius, sut.blur / 2.5)
    }
    
    func test_apply_setsShadowPropertiesWhenUseShadowPathIsTrue() {
        let sut = makeSUT(useShadowPath: true)
        let layer = makeLayer()
        
        sut.apply(layer: layer)
        
        XCTAssertEqual(layer.shadowOffset, CGSize(width: 1, height: 1))
        XCTAssertEqual(layer.shadowColor, UIColor.red.cgColor)
        XCTAssertEqual(layer.shadowOpacity, 0.5)
        XCTAssertEqual(layer.shadowRadius, sut.blur / 2.5)
    }
}

private extension ElevationTests {
    func makeSUT(
        xOffset: CGFloat = 1,
        yOffset: CGFloat = 1,
        blur: CGFloat = 2,
        spread: CGFloat = 3,
        color: UIColor = .red,
        opacity: Float = 0.5,
        useShadowPath: Bool = true
    ) -> Elevation {
        Elevation(
            xOffset: xOffset,
            yOffset: yOffset,
            blur: blur,
            spread: spread,
            color: color,
            opacity: opacity,
            useShadowPath: useShadowPath
        )
    }

    func makeLayer(cornerRadius: CGFloat = 0) -> CALayer {
        let layer = CALayer()
        layer.bounds = CGRect(origin: .zero, size: CGSize(width: 64, height: 64))
        layer.cornerRadius = cornerRadius
        return layer
    }
}

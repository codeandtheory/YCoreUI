//
//  UIScreen+scaleFactorTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 8/10/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest

final class UIScreenScaleFactorTests: XCTestCase {
    func testScaleFactor() {
        let sut = makeSUT()
        sut.forEach {
            XCTAssertNotNil($0.scaleFactor)
            XCTAssertNotEqual($0.scaleFactor.rawValue, 0)
        }
    }
}

private extension UIScreenScaleFactorTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> [UIScreen] {
        let screen0 = MockScreen(scale: 0)
        let screen1 = MockScreen(scale: 1)
        let screen2 = MockScreen(scale: 2)
        let screen3 = MockScreen(scale: 3)

        trackForMemoryLeak(screen0, file: file, line: line)
        trackForMemoryLeak(screen1, file: file, line: line)
        trackForMemoryLeak(screen2, file: file, line: line)
        trackForMemoryLeak(screen3, file: file, line: line)

        return [.main, screen0, screen1, screen2, screen3]
    }
}

private final class MockScreen: UIScreen {
    private let rawScale: CGFloat
    
    init(scale: CGFloat) {
        self.rawScale = scale
    }
    
    override var scale: CGFloat { rawScale }
}

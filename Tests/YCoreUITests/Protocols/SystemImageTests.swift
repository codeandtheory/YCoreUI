//
//  SystemImageTests.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 3/8/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YCoreUI

final class SystemImageTests: XCTestCase {
    func test_fallbackImage_deliversImage() {
        XCTAssertNotNil(Symbols.fallbackImage)
        XCTAssertEqual(MissingSymbols.fallbackImage, UIImage(systemName: "x.squareroot"))
    }

    func test_loadImage_deliversImage() {
        Symbols.allCases.forEach {
            XCTAssertNotNil($0.loadImage())
            XCTAssertNotEqual($0.image.pngData(), DefaultSymbols.fallbackImage.pngData())
        }
    }

    func test_missingImage_deliversCustomFallback() {
        YCoreUI.isLoggingEnabled = false

        MissingSymbols.allCases.forEach {
            XCTAssertNil($0.loadImage())
            XCTAssertEqual($0.image, UIImage(systemName: "x.squareroot"))
        }

        YCoreUI.isLoggingEnabled = true
    }
    
    func test_loadImageWithRenderingMode() {
        RenderMode.allCases.forEach {
            XCTAssertEqual(
                $0.loadImage()?.pngData(),
                UIImage(
                    systemName: $0.rawValue,
                    withConfiguration: RenderMode.configuration
                )?.withRenderingMode(RenderMode.renderingMode).pngData()
            )
            XCTAssertEqual($0.image.renderingMode, .alwaysOriginal)
        }
    }

    func test_defaultImageScaling() {
        XCTAssertEqual(Symbols.textStyle, .body)
        XCTAssertEqual(Symbols.configuration, UIImage.SymbolConfiguration(textStyle: .body))
    }
    
    func test_imageWithoutScaling() {
        XCTAssertNil(SymbolWithoutScaling.textStyle)
        XCTAssertNil(SymbolWithoutScaling.configuration)
    }
    
    func test_customImageScaling() {
        XCTAssertEqual(SymbolCustomScaling.textStyle, .title1)
        XCTAssertEqual(SymbolCustomScaling.configuration, UIImage.SymbolConfiguration(textStyle: .title1))
    }
    
    func test_systemImage_deliversDefaultFallback() {
        XCTAssertEqual(DefaultSymbols.defaultCase.image.pngData(), DefaultSymbols.fallbackImage.pngData())
    }
}

extension SystemImageTests {
    enum Symbols: String, CaseIterable, SystemImage {
        case checked = "checkmark.square"
        case unchecked = "square"
        case warning = "exclamationmark.triangle.fill"
        case error = "exclamationmark.octagon"
    }

    enum MissingSymbols: String, CaseIterable, SystemImage {
        case notHere
        case gone

        static var fallbackImage: UIImage {
            let image: UIImage! = UIImage(systemName: "x.squareroot")
            return image
        }
    }

    enum DefaultSymbols: String, CaseIterable, SystemImage {
        case defaultCase
    }
    
    enum SymbolWithoutScaling: String, CaseIterable, SystemImage {
        case checked = "checkmark.square"
        case unchecked = "square"

        static var textStyle: UIFont.TextStyle? { nil }
    }
    
    enum SymbolCustomScaling: String, CaseIterable, SystemImage {
        case checked = "checkmark.square"
        case unchecked = "square"

        static var textStyle: UIFont.TextStyle? { .title1 }
    }

    enum RenderMode: String, CaseIterable, SystemImage {
        case plus
        case minus
        case trash

        static var renderingMode: UIImage.RenderingMode { .alwaysOriginal }
    }
}

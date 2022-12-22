//
//  ImageAssetTests.swift
//  YCoreUI
//
//  Created by Dev Karan on 21/12/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import XCTest
import YCoreUI

final class ImageAssetTests: XCTestCase {
    
    func testBundle() {
        XCTAssertEqual(Flags.bundle, .module)
        XCTAssertEqual(Icons.bundle, .module)
    }
    
    func testNamespace() {
        XCTAssertNil(Flags.namespace)
        XCTAssertEqual(Icons.namespace, "Icons")
        XCTAssertNil(Missing.namespace)
    }
    
    func testFallbackImage() {
        XCTAssertNotNil(Flags.fallbackImage)
        XCTAssertNotNil(Icons.fallbackImage)
        XCTAssertEqual(Missing.fallbackImage, UIImage(systemName: "x.squareroot"))
    }

    func testLoadImageWithNameSpace() {
        Icons.allCases.forEach {
            XCTAssertNotNil($0.loadImage())
        }
    }
    
    func testLoadImageWithoutNameSpace() {
        Flags.allCases.forEach {
            XCTAssertNotNil($0.loadImage())
        }
    }
    
    func test_imageAsset_defaultValues() {
        XCTAssertEqual(DefaultImageAssets.bundle, .main)
    }
}

enum DefaultImageAssets: String, CaseIterable, ImageAsset {
    case plus
}

extension ImageAssetTests {
    enum Flags: String, CaseIterable, ImageAsset {
        case unitedStates = "flag_us"
        case india = "flag_in"
        case brazil = "flag_br"
        case switzerland = "flag_ch"
        
        static var bundle: Bundle { .module }
    }
    
    enum Icons: String, CaseIterable, ImageAsset {
        case plus
        case minus
        
        static var bundle: Bundle { .module }
        static var namespace: String? { "Icons" }
    }
    
    enum Missing: String, CaseIterable, ImageAsset {
        case notHere
        case gone
        
        static var fallbackImage: UIImage {
            let image: UIImage! = UIImage(systemName: "x.squareroot")
            return image
        }
    }
}

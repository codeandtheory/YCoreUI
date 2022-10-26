//
//  ColorableProtocolTest.swift
//  
//
//  Created by Y Media Labs on 26/10/22.
//

import XCTest
@testable import YCoreUI

final class ColorableProtocolTest: XCTestCase {
    
    func testColorsWithoutNamespace() {
        WarningColors.allCases.forEach {
            let color = $0.color
            XCTAssertNotEqual(color, .systemPink)
        }
    }
    
    func testColorsWithNamespace() {
        ErrorColors.allCases.forEach {
            let color = $0.color
            XCTAssertNotEqual(color, .systemPink)
        }
    }
    
    func testInvalidColor() {
        PrimaryColors.allCases.forEach {
            let color = $0.color
            XCTAssertEqual(color, .systemPink)
        }
    }
    
    
    enum ErrorColors: String, CaseIterable, Colorable {
        case error50
        case error100
        
        public static var bundle: Bundle { .module }
    }
    
    enum WarningColors: String, CaseIterable, Colorable {
        case warning50
        case warning100
        
        public static var bundle: Bundle { .module }
    }
    
    enum PrimaryColors: String, CaseIterable, Colorable {
        case primary50
        case primary100
        
        public static var bundle: Bundle { .module }
    }
    
}

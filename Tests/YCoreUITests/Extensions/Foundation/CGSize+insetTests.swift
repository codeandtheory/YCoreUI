//
//  CGSize+insetTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 8/13/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

final class CGSizeInsetTests: XCTestCase {
    typealias SizeNSInsetInputs = (
        input: (size: CGSize, insets: NSDirectionalEdgeInsets),
        output: (inset: CGSize, outset: CGSize)
    )
    
    typealias SizeUIInsetInputs = (
        input: (size: CGSize, insets: UIEdgeInsets),
        output: (inset: CGSize, outset: CGSize)
    )
    
    private let nsEdgeValues: [SizeNSInsetInputs] = [
        // all zeros
        ((.zero, .zero), (.zero, .zero)),
        // zero insets
        ((CGSize(width: 320, height: 64), .zero),
         (CGSize(width: 320, height: 64), CGSize(width: 320, height: 64))),
        // vertical-only insets
        ((CGSize(width: 320, height: 64), NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 30, trailing: 0)),
         (CGSize(width: 320, height: 24), CGSize(width: 320, height: 104))),
        // horizontal-only insets
        ((CGSize(width: 320, height: 64), NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 40)),
         (CGSize(width: 260, height: 64), CGSize(width: 380, height: 64))),
        // positive insets
        ((CGSize(width: 320, height: 64), NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)),
         (CGSize(width: 260, height: 24), CGSize(width: 380, height: 104))),
        // negative insets
        ((CGSize(width: 367, height: 128), NSDirectionalEdgeInsets(top: -15, leading: -10, bottom: -15, trailing: -10)),
         (CGSize(width: 387, height: 158), CGSize(width: 347, height: 98)))
    ]
    
    private let uiEdgeValues: [SizeUIInsetInputs] = [
        // all zeros
        ((.zero, .zero), (.zero, .zero)),
        // zero insets
        ((CGSize(width: 320, height: 64), .zero),
         (CGSize(width: 320, height: 64), CGSize(width: 320, height: 64))),
        // vertical-only insets
        ((CGSize(width: 320, height: 64), UIEdgeInsets(top: 10, left: 0, bottom: 30, right: 0)),
         (CGSize(width: 320, height: 24), CGSize(width: 320, height: 104))),
        // horizontal-only insets
        ((CGSize(width: 320, height: 64), UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)),
         (CGSize(width: 260, height: 64), CGSize(width: 380, height: 64))),
        // positive insets
        ((CGSize(width: 320, height: 64), UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)),
         (CGSize(width: 260, height: 24), CGSize(width: 380, height: 104))),
        // negative insets
        ((CGSize(width: 367, height: 128), UIEdgeInsets(top: -15, left: -10, bottom: -15, right: -10)),
         (CGSize(width: 387, height: 158), CGSize(width: 347, height: 98)))
    ]

    func testInset() {
        nsEdgeValues.forEach {
            XCTAssertEqual($0.input.size.inset(by: $0.input.insets), $0.output.inset)
        }
        
        uiEdgeValues.forEach {
            XCTAssertEqual($0.input.size.inset(by: $0.input.insets), $0.output.inset)
        }
    }
    
    func testOutset() {
        nsEdgeValues.forEach {
            XCTAssertEqual($0.input.size.outset(by: $0.input.insets), $0.output.outset)
        }
        
        uiEdgeValues.forEach {
            XCTAssertEqual($0.input.size.outset(by: $0.input.insets), $0.output.outset)
        }
    }
}

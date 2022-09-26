//
//  FormViewControllerTests.swift
//  YCoreUITests
//
//  Created by Mark Pospesel on 12/8/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCoreUI

#if os(iOS)
final class FormViewControllerTests: XCTestCase {
    func testLoadView() {
        let sut = makeSUT()
        // we expect content view to have three subviews (label + textField + button)
        XCTAssertEqual(sut.contentView.subviews.count, 3)
    }

    func testTapOutside() {
        let sut = makeSUT()
        XCTAssertNotNil(sut.tapOutsideGesture)
        XCTAssertFalse(sut.didTapOutside)
        sut.simulateTapOutside()
        XCTAssertTrue(sut.didTapOutside)
    }

    func testNoTapOutside() {
        let sut = makeSUT(allowTapOutside: false)
        XCTAssertNil(sut.tapOutsideGesture)
        XCTAssertFalse(sut.didTapOutside)
        sut.simulateTapOutside()
        XCTAssertFalse(sut.didTapOutside)
    }

    func testFitsToScreen() {
        let sut = makeSUT()
        // Given we fit content to screen
        let constraint = sut.fitContentToScreen()

        // the returned constraint matches expectations
        XCTAssertEqual(constraint.firstItem as? UIView, sut.contentView)
        XCTAssertEqual(constraint.secondItem as? UILayoutGuide, sut.view.safeAreaLayoutGuide)
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .height)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, -sut.contentInsets.vertical)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.isActive, true)
    }

    func testCompressToScreen() {
        let sut = makeSUT()
        // Given we compress content to screen
        let priority = UILayoutPriority(700)
        let constraint = sut.compressContentToScreen(priority: priority)

        // the returned constraint matches expectations
        XCTAssertEqual(constraint.firstItem as? UIView, sut.contentView)
        XCTAssertEqual(constraint.secondItem as? UILayoutGuide, sut.view.safeAreaLayoutGuide)
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .height)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, -sut.contentInsets.vertical)
        XCTAssertEqual(constraint.priority, priority)
        XCTAssertEqual(constraint.isActive, true)
    }
}

private extension FormViewControllerTests {
    func makeSUT(
        allowTapOutside: Bool? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> MockFormViewController {
        let sut = MockFormViewController(allowTapOutside: allowTapOutside)
        trackForMemoryLeak(sut, file: file, line: line)
        sut.loadViewIfNeeded()
        return sut
    }
}

fileprivate extension FormViewController {
    func simulateTapOutside() {
        guard let tapOutsideGesture = tapOutsideGesture else {
            return
        }
        didTapOutside(sender: tapOutsideGesture)
    }
}

final class MockFormViewController: FormViewController {
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Mock_Label".localized()
        return label
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Mock_Placeholder".localized()
        return textField
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Mock_CTA".localized(), for: .normal)
        return button
    }()

    let spacing: CGFloat = 16

    let allowTapOutside: Bool?
    var didTapOutside = false

    override var useTapOutsideRecognizer: Bool {
        if let allowTapOutside = allowTapOutside {
            return allowTapOutside
        }

        return super.useTapOutsideRecognizer
    }

    init(allowTapOutside: Bool?) {
        self.allowTapOutside = allowTapOutside
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.allowTapOutside = true
        super.init(coder: coder)
    }

    override func configureSubviews() {
        super.configureSubviews()

        contentView.addSubview(label)
        contentView.addSubview(textField)
        contentView.addSubview(button)

        label.constrainEdges(.notBottom)
        textField.constrain(below: label, offset: spacing)
        textField.constrainEdges(.horizontal)
        button.constrain(below: textField, offset: spacing)
        button.constrainEdges(.notTop)
    }

    override func handleTapOutside() {
        super.handleTapOutside()
        didTapOutside = true
    }
}
#endif

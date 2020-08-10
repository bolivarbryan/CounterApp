//
//  CountersTests.swift
//  CountersTests
//
//  Created by Bryan Bolivar on 9/08/20.
//

import XCTest
import UIKit
@testable import Counters

class CountersTests: XCTestCase {

    func testLanguageTranslation_ShouldLocalizeWelcometitle() {
        XCTAssertEqual(Language.Welcome.title.localizedValue, "Welcome to\nCounters")
    }
    
    func testImageLocalization_ShouldLocalizeSystemImage() {
        XCTAssertEqual(Image.lightBulb.imageRepresentation, UIImage(systemName: "lightbulb.fill"))
        XCTAssertEqual(Image.people.imageRepresentation, UIImage(systemName: "person.2.fill"))
        XCTAssertEqual(Image.trash.imageRepresentation, UIImage(systemName: "trash"))
        XCTAssertEqual(Image.share.imageRepresentation, UIImage(systemName: "square.and.arrow.up"))
        XCTAssertEqual(Image.circle.imageRepresentation, UIImage(systemName: "circle"))
        XCTAssertEqual(Image.minus.imageRepresentation, UIImage(systemName: "minus"))
        XCTAssertEqual(Image.plus.imageRepresentation, UIImage(systemName: "plus"))
        XCTAssertEqual(Image.circleCheckMark.imageRepresentation, UIImage(systemName: "checkmark.circle"))
    }
    
    func testImageLocalization_ShouldLocalizeNumberWithCircle() {
        XCTAssertEqual(Image.number(value: 42).imageRepresentation, UIImage(systemName: "42.circle.fill"))
    }

    func testTitleFont_IsHeavyWeight() {
        XCTAssertEqual(UIFont.CounterFont.title.fontName, ".SFUI-Heavy")
    }
    
    func testBodyFont_IsRegularFont() {
        XCTAssertEqual(UIFont.CounterFont.body.fontName, ".SFUI-Regular")
    }
    
    func testLargeButtonSetup() {
        let button = UIButton(frame: .zero)
        button.configureButtonStyle(size: .small)
        XCTAssertEqual(button.backgroundColor, UIColor.Pallete.tintColor)
    }
}

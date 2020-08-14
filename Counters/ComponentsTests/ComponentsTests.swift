//
//  ComponentsTests.swift
//  ComponentsTests
//
//  Created by Bryan Bolivar on 9/08/20.
//

import XCTest
@testable import Components

class ComponentsTests: XCTestCase {

    func testLanguageTranslation_ShouldLocalize() {
        XCTAssertEqual(Language.Welcome.title.localizedValue, "Welcome to\nCounters")
        XCTAssertEqual(Language.Main.selectAll.localizedValue, "Select All")
        XCTAssertEqual(Language.Edit.cancel.localizedValue, "Cancel")
        XCTAssertEqual(Language.CreateACounter.save.localizedValue, "Save")
        XCTAssertEqual(Language.Examples.back.localizedValue, "Back")
    }
    
    func testImageLocalization_ShouldLocalizeSystemImage() {
        XCTAssertEqual(Image.lightBulb.imageRepresentation, UIImage(systemName: "lightbulb.fill"))
        XCTAssertEqual(Image.people.imageRepresentation, UIImage(systemName: "person.2.fill"))
        XCTAssertEqual(Image.trash.imageRepresentation, UIImage(systemName: "trash"))
        XCTAssertEqual(Image.share.imageRepresentation, UIImage(systemName: "square.and.arrow.up"))
        XCTAssertEqual(Image.circle.imageRepresentation, UIImage(systemName: "circle"))
        XCTAssertEqual(Image.minus.imageRepresentation, UIImage(systemName: "minus"))
        XCTAssertEqual(Image.plus.imageRepresentation, UIImage(systemName: "plus"))
        XCTAssertEqual(Image.circleCheckMark.imageRepresentation, UIImage(systemName: "checkmark.circle.fill"))
    }
    
    func testImageLocalization_ShouldLocalizeNumberWithCircle() {
        let expectedImage = UIImage(systemName: "42.circle.fill",
                                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .semibold))
        
        XCTAssertEqual(Image.number(value: 42).imageRepresentation, expectedImage)
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

    func testLabelBackgroundInDebugMode() {
        UserDefaults.standard.setValue("true", forKey: "debug_mode")
        let label = UILabel(frame: .zero)
        label.configureAsTitle()
        XCTAssertEqual(label.backgroundColor, #colorLiteral(red: 0.9150560498, green: 0.9150775075, blue: 0.9150659442, alpha: 1))

        UserDefaults.standard.setValue(nil, forKey: "debug_mode")
        label.validateDebugMode()
        XCTAssertEqual(label.backgroundColor, .clear)
        
        label.configureAsViewSubtitle()
        XCTAssertEqual(label.font.familyName, ".AppleSystemUIFont")
        
        label.configureAsCellSectionTitle()
        XCTAssertEqual(label.font.familyName, ".AppleSystemUIFont")
        
        label.configureAsCellLargeTitle(enabled: true)
        XCTAssertEqual(label.font.familyName, ".AppleSystemUIFont")
    }
    
    
    func testLabelAttributesPersistsPlainText() {
        let label = UILabel(frame: .zero)
        label.text = "Testing"
        label.configureAsBody()
        XCTAssertEqual(label.attributedText?.string, "Testing")
    }
}

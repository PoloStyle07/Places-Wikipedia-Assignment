//
//  AddCustomPlaceErrorUITest.swift
//  PlacesUITests
//
//  Created by Marc Janga on 23/07/2024.
//

import XCTest

final class AddCustomPlaceErrorUITest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws { }

    func testErrorAlertShowsWhenInvalidCustomPlaceIsEntered() throws {
        let app = XCUIApplication()
        app.launch()

        let customPlaceButton = app.buttons["customPlaceButton"]
        XCTAssertTrue(customPlaceButton.waitForExistence(timeout: 2))
        
        customPlaceButton.tap()
        
        let latTextField = app.otherElements["latTextField"]
        let lonTextField = app.otherElements["lonTextField"]
        XCTAssertTrue(latTextField.waitForExistence(timeout: 2))
        XCTAssertTrue(lonTextField.waitForExistence(timeout: 2))
        
        let interalLatTextField = latTextField.textFields.element
        let interalLonTextField = lonTextField.textFields.element
        XCTAssertTrue(interalLatTextField.waitForExistence(timeout: 2))
        XCTAssertTrue(interalLonTextField.waitForExistence(timeout: 2))
        
        interalLatTextField.tap()
        interalLatTextField.typeText("wrongValue")
        
        interalLonTextField.tap()
        interalLonTextField.typeText("wrongValue")
        
        let openPlaceButton = app.buttons["openPlaceButton"]
        XCTAssertTrue(openPlaceButton.waitForExistence(timeout: 2))
        
        openPlaceButton.tap()
        
        let alert = app.alerts.element
        XCTAssertTrue(alert.waitForExistence(timeout: 2))
    }
}

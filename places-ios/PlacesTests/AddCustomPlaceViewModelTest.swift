//
//  AddCustomPlaceViewModelTest.swift
//  PlacesTests
//
//  Created by Marc Janga on 23/07/2024.
//

import XCTest
@testable import Places

final class AddCustomPlaceViewModelTest: XCTestCase {
    var coordinator: PreviewAppCoordinator!
    var sut: AddCustomPlaceViewModel!

    override func setUpWithError() throws {
        coordinator = PreviewAppCoordinator()
        sut = AddCustomPlaceViewModel(coordinator: coordinator)
    }

    override func tearDownWithError() throws { }

    func testInitialState() throws {
        XCTAssertTrue(sut.latitudeInput.isEmpty)
        XCTAssertTrue(sut.longitudeInput.isEmpty)
        XCTAssertFalse(sut.showingErrorAlert)
    }
    
    func testOpenPlaceSuccess() throws {
        let lat = 52.3547498
        let lon = 4.8339215
        let expectedUrl = URL.deepLinkUrl(lat: lat, long: lon)
        
        sut.latitudeInput = "\(lat)"
        sut.longitudeInput = "\(lon)"
        
        let placesUrl = sut.placesUrl
        
        XCTAssertEqual(placesUrl, expectedUrl)
        XCTAssertFalse(sut.latitudeInput.isEmpty)
        XCTAssertFalse(sut.longitudeInput.isEmpty)
        XCTAssertFalse(sut.showingErrorAlert)
    }

    func testOpenPlaceError() throws {
        sut.latitudeInput = "testvalue"
        sut.longitudeInput = "1232456789"
        
        let placesUrl = sut.placesUrl
        
        XCTAssertNil(placesUrl)
        XCTAssertTrue(sut.latitudeInput.isEmpty)
        XCTAssertTrue(sut.longitudeInput.isEmpty)
        XCTAssertTrue(sut.showingErrorAlert)
    }
    
    func testNavigateBack() {
        sut.back()
        
        XCTAssertEqual(coordinator.backCallCount, 1)
    }
}

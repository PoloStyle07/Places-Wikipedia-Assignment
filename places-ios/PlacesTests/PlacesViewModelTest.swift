//
//  PlacesViewModelTest.swift
//  PlacesTests
//
//  Created by Marc Janga on 23/07/2024.
//

import XCTest
@testable import Places

final class PlacesViewModelTest: XCTestCase {
    var coordinator: PreviewAppCoordinator!
    var repository: MockLocationsRepository!
    var sut: PlacesViewModel!

    override func setUpWithError() throws {
        coordinator = PreviewAppCoordinator()
        repository = MockLocationsRepository()
        sut = PlacesViewModel(coordinator: coordinator, locationsRepository: repository)
    }

    override func tearDownWithError() throws { }
    
    func testInitialState() throws {
        XCTAssertTrue(sut.locations.isEmpty)
        XCTAssertEqual(sut.viewState, .loading)
    }
    
    func testLoadLocationsSuccess() async throws {
        let locations = [
            Location(name: "Amsterdam", lat: 52.3547498, long: 4.8339215),
            Location(name: "Mumbai", lat: 19.0823998, long: 72.8111468),
            Location(name: "Copenhagen", lat: 55.6713442, long: 12.523785),
            Location(name: nil, lat: 40.4380638, long: -3.7495758)
        ]
        
        repository.getLocationsHandler = {
            .success(locations)
        }
        
        await sut.onAppear()
        
        XCTAssertFalse(sut.locations.isEmpty)
        XCTAssertEqual(sut.viewState, .success)
    }

    func testLoadLocationsError() async throws {
        repository.getLocationsHandler = {
            .failure(.internalError)
        }
        
        await sut.onAppear()
        
        XCTAssertTrue(sut.locations.isEmpty)
        XCTAssertEqual(sut.viewState, .error)
    }
    
    func testLoadLocationsErrorRetry() async throws {
        let locations = [
            Location(name: "Amsterdam", lat: 52.3547498, long: 4.8339215),
            Location(name: "Mumbai", lat: 19.0823998, long: 72.8111468),
            Location(name: "Copenhagen", lat: 55.6713442, long: 12.523785),
            Location(name: nil, lat: 40.4380638, long: -3.7495758)
        ]
        
        repository.getLocationsHandler = {
            .success(locations)
        }
        
        await sut.errorRetry()
        
        XCTAssertFalse(sut.locations.isEmpty)
        XCTAssertEqual(sut.viewState, .success)
    }
    
    func testNavigateToAddCustomPlace() {
        sut.addCustomPlace()
        
        XCTAssertEqual(coordinator.showAddCustomPlaceCallCount, 1)
    }
}

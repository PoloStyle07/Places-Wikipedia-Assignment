//
//  LocationsRepository.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import Foundation

protocol LocationsRepositoryProtocol {
    func getLocations() async -> Result<[Location], NetworkError>
}

final class LocationsRepository: LocationsRepositoryProtocol {
    let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func getLocations() async -> Result<[Location], NetworkError> {
        let result: Result<LocationContainer, NetworkError> = await networkClient.getRequest(url: .locationsUrl)
        switch result {
        case .success(let response):
            return .success(response.locations)
        case .failure(let error):
            return .failure(error)
        }
    }
}

final class PreviewLocationsRepository: LocationsRepositoryProtocol {
    private let locations = [
        Location(name: "Amsterdam", lat: 52.3547498, long: 4.8339215),
        Location(name: "Mumbai", lat: 19.0823998, long: 72.8111468),
        Location(name: "Copenhagen", lat: 55.6713442, long: 12.523785),
        Location(name: nil, lat: 40.4380638, long: -3.7495758)
    ]
    
    func getLocations() async -> Result<[Location], NetworkError> {
        .success(locations)
    }
}

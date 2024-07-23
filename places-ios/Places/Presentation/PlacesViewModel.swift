//
//  PlacesViewModel.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import Foundation

final class PlacesViewModel: ObservableObject {
    
    private let locationsRepository: LocationsRepositoryProtocol
    
    init(locationsRepository: LocationsRepositoryProtocol) {
        self.locationsRepository = locationsRepository
    }
}

//
//  AddCustomPlaceViewModel.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import Foundation

final class AddCustomPlaceViewModel: ObservableObject {
    @Published var latitudeInput = ""
    @Published var longitudeInput = ""
    @Published var showingErrorAlert = false
    
    private let coordinator: AppCoordinatorProtocol
    
    init(
        coordinator: AppCoordinatorProtocol
    ) {
        self.coordinator = coordinator
    }
    
    var placesUrl: URL? {
        if let lat = Double(latitudeInput), let lon = Double(longitudeInput) {
            return .deepLinkUrl(lat: lat, long: lon)
        } else {
            latitudeInput = ""
            longitudeInput = ""
            showingErrorAlert = true
            return nil
        }
    }
}

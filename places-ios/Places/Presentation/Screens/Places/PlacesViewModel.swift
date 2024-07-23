//
//  PlacesViewModel.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import Foundation

final class PlacesViewModel: ObservableObject {
    
    enum ViewState {
        case loading
        case success
        case error
    }
    
    private(set) var locations: [Location] = []
    @Published private(set) var viewState: ViewState = .loading
    
    private let coordinator: AppCoordinatorProtocol
    private let locationsRepository: LocationsRepositoryProtocol
    
    init(
        coordinator: AppCoordinatorProtocol,
        locationsRepository: LocationsRepositoryProtocol
    ) {
        self.coordinator = coordinator
        self.locationsRepository = locationsRepository
    }
    
    func onAppear() async {
        await loadLocations()
    }
    
    func errorRetry() async {
        await loadLocations()
    }
    
    func addCustomPlace() {
        coordinator.showAddCustomPlace()
    }
}

private extension PlacesViewModel {
    func loadLocations() async {
        await MainActor.run {
            viewState = .loading
        }
        
        let result = await locationsRepository.getLocations()
        switch result {
        case .success(let locationsResponse):
            await MainActor.run {
                locations = locationsResponse
                viewState = .success
            }
        case .failure(let error):
            print("Locations load error: \(error)")
            await MainActor.run {
                locations = []
                viewState = .error
            }
        }
    }
}

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
    
    @Published var locations: [Location] = []
    @Published var viewState: ViewState = .loading
    
    private let coordinator: AppCoordinatorProtocol
    private let locationsRepository: LocationsRepositoryProtocol
    
    init(
        coordinator: AppCoordinatorProtocol,
        locationsRepository: LocationsRepositoryProtocol
    ) {
        self.coordinator = coordinator
        self.locationsRepository = locationsRepository
    }
    
    func onAppear() {
        loadLocations()
    }
    
    func errorRetry() {
        loadLocations()
    }
    
    func addCustomPlace() {
        coordinator.showAddCustomPlace()
    }
}

private extension PlacesViewModel {
    func loadLocations() {
        viewState = .loading
        
        Task {
            let result = await locationsRepository.getLocations()
            switch result {
            case .success(let locationsResponse):
                Task {
                    await MainActor.run {
                        locations = locationsResponse
                        viewState = .success
                    }
                }
            case .failure(let error):
                print("Locations load error: \(error)")
                Task {
                    await MainActor.run {
                        viewState = .error
                    }
                }
            }
        }
    }
}

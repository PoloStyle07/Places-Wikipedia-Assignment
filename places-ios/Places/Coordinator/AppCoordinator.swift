//
//  AppCoordinator.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import SwiftUI

protocol AppCoordinatorProtocol {
    func showAddCustomPlace()
    func back()
}

enum Screen: String {
    case addCustomPlace = "addCustomPlace"
}

struct AppCoordinator: View, AppCoordinatorProtocol {
    @State private var paths = [Screen]()
    
    private let locationsRepository: LocationsRepositoryProtocol
    
    init(locationsRepository: LocationsRepositoryProtocol) {
        self.locationsRepository = locationsRepository
    }
    
    func showAddCustomPlace() {
        paths.append(.addCustomPlace)
    }
    
    func back() {
        paths.removeLast()
    }
    
    var body: some View {
        NavigationStack(path: $paths) {
            PlacesView(
                viewModel: PlacesViewModel(
                    coordinator: self,
                    locationsRepository: locationsRepository
                )
            )
            .navigationDestination(for: Screen.self) { screen in
                if screen == .addCustomPlace {
                    AddCustomPlaceView(
                        viewModel: AddCustomPlaceViewModel(
                            coordinator: self
                        )
                    )
                }
            }
        }
    }
}

final class PreviewAppCoordinator: AppCoordinatorProtocol {
    
    private(set) var showAddCustomPlaceCallCount = 0
    private(set) var backCallCount = 0
    
    func showAddCustomPlace() {
        showAddCustomPlaceCallCount += 1
    }
    
    func back() {
        backCallCount += 1
    }
}

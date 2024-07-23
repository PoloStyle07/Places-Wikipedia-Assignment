//
//  PlacesApp.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import SwiftUI

@main
struct PlacesApp: App {
    var body: some Scene {
        WindowGroup {
            let locationsRepository = LocationsRepository(networkClient: NetworkClient())
            
            NavigationStack {
                PlacesView(
                    viewModel: PlacesViewModel(
                        locationsRepository: locationsRepository
                    )
                )
            }
        }
    }
}

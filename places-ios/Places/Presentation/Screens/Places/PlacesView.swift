//
//  PlacesView.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import SwiftUI

struct PlacesView: View {
    
    @ObservedObject private var viewModel: PlacesViewModel
        
    init(viewModel: PlacesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            switch viewModel.viewState {
            case .loading:
                loadingView
            case .error:
                errorView
            case .success:
                listView
            }
        }
        .navigationTitle("Places")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut, value: viewModel.viewState)
        .task {
            await viewModel.onAppear()
        }
    }
    
    private var loadingView: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .scaleEffect(2.0)
    }
    
    private var errorView: some View {
        VStack {
            Spacer()
            Text("Error! Could not load places")
            Button("Try again") {
                Task {
                    await viewModel.errorRetry()
                }
            }
            .buttonStyle(BorderedProminentButtonStyle())
            Spacer()
        }
    }
    
    private var listView: some View {
        VStack {
            List {
                ForEach(viewModel.locations, id:\.self) { location in
                    PlacesLinkView(location: location)
                }
            }
            .listStyle(PlainListStyle())
            .accessibilityLabel("Places, List")
            Button("Open Custom Place", action: viewModel.addCustomPlace)
                .accessibilityIdentifier("customPlaceButton")
                .buttonStyle(BorderedProminentButtonStyle())
                .padding()
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        PlacesView(
            viewModel: PlacesViewModel(
                coordinator: PreviewAppCoordinator(),
                locationsRepository: PreviewLocationsRepository()
            )
        )
    }
}

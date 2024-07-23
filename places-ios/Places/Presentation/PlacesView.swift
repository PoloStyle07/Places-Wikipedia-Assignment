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
        VStack {
            if viewModel.viewState == .loading {
                loadingView
            } else if viewModel.viewState == .error {
                errorView
            } else if viewModel.viewState == .success {
                listView
            }
        }
        .navigationTitle("Places")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut, value: viewModel.viewState)
        .onAppear(perform: viewModel.onAppear)
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
            Button("Try again", action: viewModel.errorRetry)
                .buttonStyle(BorderedProminentButtonStyle())
            Spacer()
        }
    }
    
    private var listView: some View {
        VStack {
            List {
                ForEach(viewModel.locations, id:\.self) { location in
                    PlacesItemView(location: location) {
                        viewModel.selected(location: location)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    NavigationStack {
        PlacesView(
            viewModel: PlacesViewModel(
                locationsRepository: PreviewLocationsRepository()
            )
        )
    }
}

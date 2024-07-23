//
//  AddCustomPlaceView.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import SwiftUI

struct AddCustomPlaceView: View {
    @Environment(\.openURL) private var openURL
    @ObservedObject private var viewModel: AddCustomPlaceViewModel
    
    init(viewModel: AddCustomPlaceViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 24) {
            LabelTextField(title: "Latitude", input: $viewModel.latitudeInput)
                .keyboardType(.numbersAndPunctuation)
            LabelTextField(title: "Longitude", input: $viewModel.longitudeInput)
                .keyboardType(.numbersAndPunctuation)
            Button("Open Place") {
                if let placesUrl = viewModel.placesUrl {
                    openURL(placesUrl) { canOpen in
                        print("Can open \(canOpen)")
                    }
                }
            }
            .buttonStyle(BorderedProminentButtonStyle())
            Spacer()
        }
        .padding(16)
        .navigationTitle("Custom Place")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $viewModel.showingErrorAlert) {
            Alert(title: Text("Please enter a valid longitude and latitude"))
        }
    }
}

#Preview {
    NavigationStack {
        AddCustomPlaceView(
            viewModel: AddCustomPlaceViewModel(
                coordinator: PreviewAppCoordinator()
            )
        )
    }
}

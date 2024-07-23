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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PlacesView(
        viewModel: PlacesViewModel()
    )
}

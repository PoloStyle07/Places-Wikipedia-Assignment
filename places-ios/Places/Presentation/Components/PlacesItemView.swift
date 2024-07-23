//
//  PlacesItemView.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import SwiftUI

struct PlacesItemView: View {
    let location: Location
    let action: () -> Void
    
    var body: some View {
        Button(
            action: action,
            label: {
                HStack(spacing: 16) {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.blue)
                    VStack(alignment: .leading) {
                        Text(location.name ?? "Unknown")
                        Text("lat: \(location.lat), long: \(location.long)")
                            .font(.caption)
                    }
                }
            }
        )
    }
}

#Preview {
    List {
        PlacesItemView(
            location: Location(name: "Amsterdam", lat: 52.3547498, long: 4.8339215),
            action: {}
        )
    }
    .listStyle(PlainListStyle())
}

//
//  PlacesLinkView.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import SwiftUI

struct PlacesLinkView: View {
    let location: Location
    
    var body: some View {
        Link(destination: url) {
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
        .accessibilityElement()
        .accessibilityLabel("\(location.name ?? "Unknown") place, Button, Link")
    }
    
    private var url: URL {
        .deepLinkUrl(lat: location.lat, long: location.long)!
    }
}

#Preview {
    List {
        PlacesLinkView(
            location: Location(name: "Amsterdam", lat: 52.3547498, long: 4.8339215)
        )
    }
    .listStyle(PlainListStyle())
}

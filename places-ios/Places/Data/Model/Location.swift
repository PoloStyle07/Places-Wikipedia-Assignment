//
//  Location.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import Foundation

struct Location: Decodable {
    let name: String?
    let lat: Double
    let long: Double
}

struct LocationContainer: Decodable {
    let locations: [Location]
}

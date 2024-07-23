//
//  URL+.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import Foundation

extension URL {
    static var locationsUrl: URL? {
        URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json")
    }
}

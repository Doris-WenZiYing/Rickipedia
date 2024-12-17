//
//  Locations.swift
//  Rickipedia
//
//  Created by App_team on 2024/12/17.
//

import Foundation

struct Locations: Codable {
    let info: LocationInfo
    let results: [Location]
}

struct LocationInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
}

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

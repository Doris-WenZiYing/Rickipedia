//
//  Characters.swift
//  Rickipedia
//
//  Created by App_team on 2024/12/14.
//

import Foundation

struct Characters: Codable {
    let info: CharacterInfo
    let results: [Character]
}

struct CharacterInfo: Codable {
    let count, page: Int?
    let next, prev: String?
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct CharacterLocation: Codable {
    let name: String
    let url: String
}

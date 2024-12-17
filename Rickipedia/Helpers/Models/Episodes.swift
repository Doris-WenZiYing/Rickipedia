//
//  Episodes.swift
//  Rickipedia
//
//  Created by App_team on 2024/12/17.
//

import Foundation

struct Episodes: Codable {
    let info: EpisodeInfo
    let results: [Episode]
}

struct EpisodeInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
}

struct Episode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

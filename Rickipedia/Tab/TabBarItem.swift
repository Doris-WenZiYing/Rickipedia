//
//  TabBarItem.swift
//  Rickipedia
//
//  Created by App_team on 2024/12/14.
//

import Foundation

struct TabItem {
    let title: String
    let icon: String
    
    static let allItems: [TabItem] = [
        TabItem(title: "Characters", icon: "person.3"),
        TabItem(title: "Locations", icon: "globe.americas.fill"),
        TabItem(title: "Episodes", icon: "tv")
    ]
}

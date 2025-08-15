//
//  MenuModels.swift
//  NewsFeed
//
//  Created by Neto Moura on 15/08/25.
//

import Foundation

struct MenuResponse: Codable {
    let menuItems: [MenuItem]
}

struct MenuItem: Codable, Identifiable {
    let id = UUID()
    let title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case title, url
    }
}

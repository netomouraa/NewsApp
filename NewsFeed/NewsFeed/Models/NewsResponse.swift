//
//  NewsResponse.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import Foundation

struct NewsResponse: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let oferta: String
    let falkor: Falkor
}

struct Falkor: Codable {
    let items: [NewsItem]
}

struct NewsItem: Codable, Identifiable {
    let id: String
    let type: String
    let content: NewsContent?
    let metadata: String?
    
    var isValid: Bool {
        type == "basico" || type == "materia"
    }
}

struct NewsContent: Codable {
    let title: String?
    let summary: String?
    let url: String?
    let chapeu: String?
    let image: NewsImage?
}

struct NewsImage: Codable {
    let url: String
}

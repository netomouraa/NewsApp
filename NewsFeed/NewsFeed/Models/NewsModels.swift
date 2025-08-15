//
//  NewsModels.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import Foundation

struct NewsResponse: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let oferta: String?
    let falkor: Falkor
}

struct Falkor: Codable {
    let items: [NewsItem]
    let nextPage: Int
}

struct NewsItem: Codable, Identifiable {
    let id: String?
    let type: String?
    let content: NewsContent?
    let metadata: String?
        
    var isValid: Bool {
        type == "basico" || type == "materia"
    }

}

struct NewsContent: Codable {
    let chapeu: Chapeu?
    let image: NewsImage?
    let summary: String?
    let title: String?
    let url: String?
}

struct Chapeu: Codable {
    let label: String?
}

struct NewsImage: Codable {
    let url: String?
    let sizes: NewsImageSizes?
}

struct NewsImageSizes: Codable {
    let Q: QSize?
}

struct QSize: Codable {
    let url: String?
}

//
//  Article.swift
//  NewsApp
//
//  Created by Neto Moura on 11/08/25.
//

import Foundation

struct Article: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let summary: String?
    let imageURL: String?
    let url: String
    let section: String?
    let chapeu: String?
    let metadata: String?
    
    var displaySection: String {
        return chapeu ?? section ?? "G1"
    }
    
    var displayTime: String {
        guard let metadata = metadata else { return "" }
        
        if let timeRange = metadata.range(of: "Há \\d+\\s+(minutos?|horas?|dias?)", options: .regularExpression) {
            return String(metadata[timeRange])
        }
        
        return metadata.components(separatedBy: " — ").first ?? ""
    }
    
    var hasChapeu: Bool {
        return chapeu != nil && !chapeu!.isEmpty
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.id == rhs.id
    }
}

struct Resource: Codable {
    let description: String
    let title: String
}

struct ContentType: Codable {
    let api: String
    let name: String
}

struct Feed: Codable {
    let oferta: String
    let falkor: Falkor
}

struct Falkor: Codable {
    let items: [FeedItem]
}

struct FeedItem: Codable {
    var isValidForDisplay: Bool {
        return type == "basico" || type == "materia"
    }
    
    let id: String
    let type: String
    let content: Content?
    let metadata: String?
}

struct Content: Codable {
    let chapeu: Chapeu?
    let image: NewsImage?
    let missingFields: Bool?
    let section: String?
    let summary: String?
    let title: String
    let type: String
    let url: String
    let video: String?
}

struct Chapeu: Codable {
    let label: String
}

struct NewsImage: Codable {
    let url: String
}

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
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.id == rhs.id
    }
}

//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Neto Moura on 11/08/25.
//

import Foundation

struct NewsResponse: Codable {
    let resource: Resource
    let contentType: ContentType
    let feed: Feed
    
    enum CodingKeys: String, CodingKey {
        case resource
        case contentType = "content_type"
        case feed
    }
}

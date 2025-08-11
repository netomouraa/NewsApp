//
//  NewsService.swift
//  NewsApp
//
//  Created by Neto Moura on 11/08/25.
//

import Foundation

class NewsService: ObservableObject {
    private let baseURL = "https://native-leon.globo.com/feed/g1"
    private let session = URLSession.shared
    
    func fetchNews() async throws -> [Article] {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
        
        return newsResponse.feed.falkor.items.compactMap { item in
            guard let content = item.content else { return nil }
            
            return Article(
                id: item.id,
                title: content.title,
                summary: content.summary,
                imageURL: content.image?.url,
                url: content.url,
                section: content.section,
                chapeu: content.chapeu?.label,
                metadata: item.metadata
            )
        }
    }
}

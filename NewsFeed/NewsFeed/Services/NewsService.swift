//
//  NewsService.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import Foundation
import Combine

class NewsService: ObservableObject {
    static let shared = NewsService()
    
    private let baseURL = "https://native-leon.globo.com"
    
    func fetchFeed() -> AnyPublisher<NewsResponse, Error> {
        guard let url = URL(string: "\(baseURL)/feed/g1") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchPage(ofertaId: String, page: Int) -> AnyPublisher<NewsResponse, Error> {
        guard let url = URL(string: "\(baseURL)/feed/page/g1/\(ofertaId)/\(page)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

//
//  NewsService.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import Foundation
import Combine

enum FeedType: String, CaseIterable {
    case g1 = "g1"
    case agronegocio = "https://g1.globo.com/economia/agronegocios"
    
    var title: String {
        switch self {
        case .g1:
            return "G1"
        case .agronegocio:
            return "Agronegócio"
        }
    }
}

protocol NewsServiceProtocol {
    func fetchFeed(type: FeedType) -> AnyPublisher<NewsResponse, Error>
    func fetchPage(type: FeedType, ofertaId: String, page: Int) -> AnyPublisher<NewsResponse, Error>
}

class NewsService: NewsServiceProtocol {
    static let shared = NewsService()
    
    private let baseURL = "https://native-leon.globo.com"
    
    private init() {}
    
    func fetchFeed(type: FeedType) -> AnyPublisher<NewsResponse, Error> {
        let urlString = "\(baseURL)/feed/\(type.rawValue)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchPage(type: FeedType, ofertaId: String, page: Int) -> AnyPublisher<NewsResponse, Error> {
        let urlString = "\(baseURL)/feed/page/\(type.rawValue)/\(ofertaId)/\(page)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

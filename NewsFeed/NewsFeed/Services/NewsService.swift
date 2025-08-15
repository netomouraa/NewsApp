//
//  NewsService.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import Foundation
import Combine

enum FeedType {
    case g1
    case agronegocio
    
    var url: String {
        switch self {
        case .g1:
            return "https://native-leon.globo.com/feed/g1"
        case .agronegocio:
            return "https://native-leon.globo.com/feed/https://g1.globo.com/economia/agronegocios"
        }
    }
    
    var pageIdentifier: String {
        switch self {
        case .g1:
            return "g1"
        case .agronegocio:
            return "https://g1.globo.com/economia/agronegocios"
        }
    }
    
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
    
    func fetchFeed(type: FeedType) -> AnyPublisher<NewsResponse, Error> {
        guard let url = URL(string: type.url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchPage(type: FeedType, ofertaId: String, page: Int) -> AnyPublisher<NewsResponse, Error> {
        guard let url = URL(string: "\(baseURL)/feed/page/\(type.pageIdentifier)/\(ofertaId)/\(page)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

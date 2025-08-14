//
//  NewsFeedService.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import Foundation
import Combine

class NewsFeedService: ObservableObject {
    static let shared = NewsFeedService()
    
    private let baseURL = "https://native-leon.globo.com"
    
    func fetchFeed() -> AnyPublisher<NewsFeedResponse, Error> {
        guard let url = URL(string: "\(baseURL)/feed/g1") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsFeedResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

//
//  NewsViewModel.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import Foundation
import Combine

@MainActor
class NewsViewModel: ObservableObject {
    @Published var items: [NewsItem] = []
    @Published var error: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let service = NewsService.shared
    private let mockService = MockNewsService.shared

    func loadFeed() {
        error = nil
        
//        service.fetchFeed()
        mockService.fetchFeed()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure = completion {
                        self?.error = "Erro ao carregar notícias"
                    }
                },
                receiveValue: { [weak self] response in
                    self?.items = response.feed.falkor.items.filter { $0.isValid }
                }
            )
            .store(in: &cancellables)
    }
}

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
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var error: String?
    @Published var hasMorePages = true
    
    private var cancellables = Set<AnyCancellable>()
    private let service: NewsServiceProtocol
    private let feedType: FeedType
    private var currentOfertaId: String?
    private var currentPage = 1
    
    init(feedType: FeedType, service: NewsServiceProtocol = NewsService.shared) {
        self.feedType = feedType
        self.service = service
    }
    
    func loadFeed() {
        isLoading = true
        error = nil
        
        service.fetchFeed(type: feedType)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure = completion {
                        self?.error = "Erro ao carregar notícias"
                    }
                },
                receiveValue: { [weak self] response in
                    self?.currentOfertaId = response.feed.oferta
                    self?.items = response.feed.falkor.items.filter { $0.isValid }
                    self?.currentPage = 1
                }
            )
            .store(in: &cancellables)
    }
    
    func loadMoreIfNeeded(currentItem: NewsItem) {
        let thresholdIndex = items.index(items.endIndex, offsetBy: -3)
        if let itemIndex = items.firstIndex(where: { $0.id == currentItem.id }),
           itemIndex >= thresholdIndex {
            loadMore()
        }
    }
    
    private func loadMore() {
        guard let ofertaId = currentOfertaId,
              hasMorePages,
              !isLoadingMore else { return }
        
        currentPage += 1
        isLoadingMore = true
        
        service.fetchPage(type: feedType, ofertaId: ofertaId, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoadingMore = false
                    if case .failure(let error) = completion {
                        print("Erro ao carregar mais: \(error)")
                        self?.currentPage -= 1
                    }
                },
                receiveValue: { [weak self] response in
                    let newItems = response.feed.falkor.items.filter { $0.isValid }
                    if newItems.isEmpty {
                        self?.hasMorePages = false
                    } else {
                        self?.items.append(contentsOf: newItems)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    func refresh() {
        items.removeAll()
        hasMorePages = true
        loadFeed()
    }
}

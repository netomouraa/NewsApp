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
    
    private var cancellables = Set<AnyCancellable>()
    private var ofertaId: String?
    private var currentPage = 1
    private let service = NewsService.shared
    private let mockService = MockNewsService.shared

    func loadFeed() {
        isLoading = true
        error = nil
        
//        service.fetchFeed()
        mockService.fetchFeed()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure = completion {
                        self?.error = "Erro ao carregar notícias"
                    }
                },
                receiveValue: { [weak self] response in
                    self?.ofertaId = response.feed.oferta
                    self?.items = response.feed.falkor.items.filter { $0.isValid }
                    self?.currentPage = 1
                }
            )
            .store(in: &cancellables)
    }
    
    func loadMore() {
        guard let ofertaId = ofertaId, !isLoadingMore else { return }
        
        currentPage += 1
        isLoadingMore = true
        
        service.fetchPage(ofertaId: ofertaId, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoadingMore = false
                    if case .failure = completion {
                        self?.currentPage -= 1
                    }
                },
                receiveValue: { [weak self] response in
                    let newItems = response.feed.falkor.items.filter { $0.isValid }
                    self?.items.append(contentsOf: newItems)
                }
            )
            .store(in: &cancellables)
    }
    
    func refresh() {
        items.removeAll()
        loadFeed()
    }
}

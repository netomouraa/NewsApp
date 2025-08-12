//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Neto Moura on 11/08/25.
//

import Foundation
import SwiftUI

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let newsService = NewsService()
    
    init() {
        Task {
            await loadNews()
        }
    }
    
    @MainActor
    func loadNews() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedArticles = try await newsService.fetchNews()
                articles = fetchedArticles
            } catch {
                errorMessage = "Erro ao carregar notícias: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }

}

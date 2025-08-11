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
                
                if articles.isEmpty {
                    loadMockData()
                }
            }
            isLoading = false
        }
    }
    
    @MainActor
    private func loadMockData() {
        articles = [
            Article(
                id: "mock-1",
                title: "Haddad diz que secretário de Trump cancelou reunião após articulação da extrema direita",
                summary: "Depois de iniciar tratativas com Haddad, Scott Bessent escreveu na sua rede social que Moraes é 'responsável por detenções arbitrárias que violam direitos humanos'.",
                imageURL: "https://i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2025/B/R/ophf2cSYmHyzBC9rEBNQ/2025-08-11t144202z-309299391-rc225gaz7r6d-rtrmadp-3-usa-trump-crime.jpg",
                url: "https://g1.globo.com/politica/blog/andreia-sadi/post/2025/08/11/ministro-fernando-haddad-tarifaco-entrevista-estudio-i.ghtml",
                section: "Blog da Andréia Sadi",
                chapeu: "Blog da Andréia Sadi",
                metadata: "Há 2 horas — Em Blog da Andréia Sadi"
            ),
            Article(
                id: "mock-2",
                title: "Economia brasileira cresce 2,1% no segundo trimestre",
                summary: "PIB supera expectativas e mostra sinais de recuperação sustentável da economia nacional.",
                imageURL: nil,
                url: "https://g1.globo.com/economia/noticia/2025/08/11/economia.ghtml",
                section: "Economia",
                chapeu: "Economia",
                metadata: "Há 3 horas — Em Economia"
            ),
            Article(
                id: "mock-3",
                title: "Nova descoberta científica revoluciona tratamento contra o câncer",
                summary: "Pesquisadores brasileiros desenvolvem terapia inovadora que aumenta chances de cura em 40%.",
                imageURL: nil,
                url: "https://g1.globo.com/ciencia/noticia/2025/08/11/cancer.ghtml",
                section: "Ciência e Saúde",
                chapeu: "Ciência e Saúde",
                metadata: "Há 4 horas — Em Ciência e Saúde"
            )
        ]
    }
}

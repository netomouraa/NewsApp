//
//  MockNewsService.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import Foundation
import Combine

class MockNewsService: NewsServiceProtocol {
    static let shared = MockNewsService()
    
    private init() {}
    
    func fetchFeed(type: FeedType) -> AnyPublisher<NewsResponse, Error> {
        let mockResponse = NewsResponse(
            feed: Feed(
                oferta: "mock-oferta-\(type.title.lowercased())",
                falkor: Falkor(items: getMockItems(for: type))
            )
        )
        
        return Just(mockResponse)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchPage(type: FeedType, ofertaId: String, page: Int) -> AnyPublisher<NewsResponse, Error> {
        let mockResponse = NewsResponse(
            feed: Feed(
                oferta: ofertaId,
                falkor: Falkor(items: getMockItems(for: type, page: page))
            )
        )
        
        return Just(mockResponse)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    private func getMockItems(for type: FeedType, page: Int = 1) -> [NewsItem] {
        switch type {
        case .g1:
            return [
                NewsItem(
                    id: "g1-\(page)-1",
                    type: "materia",
                    content: NewsContent(
                        title: "Dono da Ultrafarma é preso em operação da PF",
                        summary: "Operação mira esquema de corrupção que movimentou R$ 1 bilhão.",
                        url: "https://g1.globo.com/exemplo",
                        chapeu: "OPERAÇÃO POLICIAL",
                        image: NewsImage(url: "https://picsum.photos/300/200?random=\(page)1")
                    ),
                    metadata: "Há \(page) hora — Em São Paulo"
                ),
                NewsItem(
                    id: "g1-\(page)-2",
                    type: "materia",
                    content: NewsContent(
                        title: "Brasil vence mais uma no Mundial",
                        summary: "Seleção garantiu vaga nas semifinais com gol nos acréscimos.",
                        url: "https://g1.globo.com/exemplo2",
                        chapeu: "ESPORTE",
                        image: NewsImage(url: "https://picsum.photos/300/200?random=\(page)2")
                    ),
                    metadata: "Há \(page + 1) horas"
                )
            ]
        case .agronegocio:
            return [
                NewsItem(
                    id: "agro-\(page)-1",
                    type: "materia",
                    content: NewsContent(
                        title: "Safra de soja bate recorde no Brasil",
                        summary: "Produção alcança 154 milhões de toneladas na temporada 2024/25.",
                        url: "https://g1.globo.com/agro/exemplo",
                        chapeu: "SAFRA 2024/25",
                        image: NewsImage(url: "https://picsum.photos/300/200?random=\(page)10")
                    ),
                    metadata: "Há \(page) hora — No campo"
                ),
                NewsItem(
                    id: "agro-\(page)-2",
                    type: "basico",
                    content: NewsContent(
                        title: "Preço do boi gordo sobe 5% na semana",
                        summary: "Alta é reflexo da maior demanda por carne no mercado interno.",
                        url: "https://g1.globo.com/agro/exemplo2",
                        chapeu: nil,
                        image: NewsImage(url: "https://picsum.photos/300/200?random=\(page)11")
                    ),
                    metadata: "Há \(page + 2) horas — Mercado"
                )
            ]
        }
    }
}

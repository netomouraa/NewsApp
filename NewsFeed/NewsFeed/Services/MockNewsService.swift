//
//  MockNewsService.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import Foundation
import Combine

class MockNewsService {
    static let shared = MockNewsService()
    
    private init() {}
    
    func fetchFeed() -> AnyPublisher<NewsResponse, Error> {
        let mockResponse = NewsResponse(
            feed: Feed(
                oferta: "mock-oferta-id",
                falkor: Falkor(
                    items: [
                        NewsItem(
                            id: "1",
                            type: "materia",
                            content: NewsContent(
                                title: "Dono da Ultrafarma, diretor da Fast Shop e auditor fiscal são presos em SP",
                                summary: "Operação mira esquema de corrupção que movimentou R$ 1 bilhão em propina.",
                                url: "https://g1.globo.com/sp/sao-paulo/noticia/2025/08/12/exemplo.ghtml",
                                chapeu: "OPERAÇÃO POLICIAL",
                                image: NewsImage(url: "https://picsum.photos/300/200?random=1")
                            ),
                            metadata: "Há 1 hora — Em São Paulo"
                        ),
                        NewsItem(
                            id: "2",
                            type: "materia",
                            content: NewsContent(
                                title: "Novo programa social vai beneficiar milhões de brasileiros",
                                summary: "Governo anuncia investimento de R$ 5 bilhões em programa de auxílio habitacional.",
                                url: "https://g1.globo.com/politica/noticia/2025/08/12/exemplo2.ghtml",
                                chapeu: "POLÍTICA",
                                image: NewsImage(url: "https://picsum.photos/300/200?random=2")
                            ),
                            metadata: "Há 2 horas — Em Brasília"
                        ),
                        NewsItem(
                            id: "3",
                            type: "basico",
                            content: NewsContent(
                                title: "Previsão do tempo para o fim de semana",
                                summary: "Chuva intensa deve atingir região Sul do país nos próximos dias.",
                                url: "https://g1.globo.com/clima/noticia/2025/08/12/exemplo3.ghtml",
                                chapeu: nil,
                                image: NewsImage(url: "https://picsum.photos/300/200?random=3")
                            ),
                            metadata: "Há 3 horas"
                        )
                    ]
                )
            )
        )
        
        return Just(mockResponse)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

////
////  MockNewsService.swift
////  NewsFeed
////
////  Created by Neto Moura on 14/08/25.
////

import Foundation

struct MockNewsService {
    
    static let mockResponse = NewsResponse(
        feed: Feed(
            oferta: "4af56893-1f9a-4504-9531-74458e481f91",
            falkor: Falkor(
                items: [
                    NewsItem(
                        id: "pre-feed-1",
                        type: "pre-feed",
                        content: nil,
                        metadata: nil
                    ),
                    
                    NewsItem(
                        id: "materia-1",
                        type: "materia",
                        content: NewsContent(
                            chapeu: Chapeu(label: "Política"),
                            image: NewsImage(url: "https://example.com/image.jpg"),
                            summary: "Resumo da notícia de teste",
                            title: "Título da notícia de teste",
                            url: "https://g1.globo.com/teste.html",
                        ),
                        metadata: "Há 1 hora"
                    )
                ],
                nextPage: 2
            )
        )
    )
}

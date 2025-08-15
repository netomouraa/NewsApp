//
//  NewsServiceTests.swift
//  NewsFeedTests
//
//  Created by Neto Moura on 15/08/25.
//

import XCTest
import Combine
@testable import NewsFeed
import SwiftUI

class NewsServiceTests: XCTestCase {
    var sut: NewsService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        sut = NewsService.shared
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables = nil
        sut = nil
        super.tearDown()
    }
    
    func testFetchFeedSuccess() {
        let expectation = XCTestExpectation(description: "Fetch feed success")
        
        sut.fetchFeed(type: .g1)
            .sink(
                receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Should not fail")
                    }
                },
                receiveValue: { response in
                    XCTAssertNotNil(response)
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchPageWithValidParameters() {
        let expectation = XCTestExpectation(description: "Fetch page success")
        
        sut.fetchPage(type: .g1, ofertaId: "test123", page: 1)
            .sink(
                receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Should not fail")
                    }
                },
                receiveValue: { response in
                    XCTAssertNotNil(response)
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
}

class MockNewsService: NewsServiceProtocol {
    var shouldFail = false
    var mockResponse: NewsResponse?
    
    func fetchFeed(type: FeedType) -> AnyPublisher<NewsResponse, Error> {
        if shouldFail {
            return Fail(error: URLError(.networkConnectionLost))
                .eraseToAnyPublisher()
        }
        
        return Just(mockResponse ?? createMockResponse())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchPage(type: FeedType, ofertaId: String, page: Int) -> AnyPublisher<NewsResponse, Error> {
        if shouldFail {
            return Fail(error: URLError(.networkConnectionLost))
                .eraseToAnyPublisher()
        }
        
        return Just(mockResponse ?? createMockResponse())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    private func createMockResponse() -> NewsResponse {
        return NewsResponse(
            feed: Feed(
                oferta: "mock123",
                falkor: Falkor(items: [createMockNewsItem()],
                nextPage: 1)
            )
        )
    }
    
    private func createMockNewsItem() -> NewsItem {
        return NewsItem(
            id: "1",
            type: "materia",
            content: NewsContent(
                chapeu: Chapeu(label: "Tech"),
                image:  NewsImage(url: "https://example.com/image.jpg"),
                summary:"Mock summary",
                title: "Mock News",
                url: "https://example.com"
            ),
            metadata: "2h ago"
        )
    }
}

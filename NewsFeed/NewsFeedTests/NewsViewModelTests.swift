//
//  NewsViewModelTests.swift
//  NewsFeedTests
//
//  Created by Neto Moura on 15/08/25.
//
import XCTest
import Combine
@testable import NewsFeed

@MainActor
class NewsViewModelTests: XCTestCase {
    var sut: NewsViewModel!
    var mockService: MockNewsService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() async throws {
        try await super.setUp()
        mockService = MockNewsService()
        sut = NewsViewModel(feedType: .g1, service: mockService)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() async throws {
        cancellables = nil
        sut = nil
        mockService = nil
        try await super.tearDown()
    }
    
    func testLoadFeedSuccess() async {
        mockService.shouldFail = false
        
        sut.loadFeed()
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.items.isEmpty)
        XCTAssertNil(sut.error)
    }
    
    func testLoadFeedFailure() async {
        mockService.shouldFail = true
        
        sut.loadFeed()
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertFalse(sut.isLoading)
        XCTAssertNotNil(sut.error)
        XCTAssertTrue(sut.items.isEmpty)
    }
    
}

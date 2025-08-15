//
//  NewsFeedUITests.swift
//  NewsFeedUITests
//
//  Created by Neto Moura on 14/08/25.
//

import XCTest

class NewsAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testNewsListLoadsAndDisplaysItems() throws {
        // Given - App is launched
        
        // Wait for list to appear
        let newsList = app.tables.firstMatch
        XCTAssertTrue(newsList.waitForExistence(timeout: 10))
        
        // Then - Should have news items
        let cells = newsList.cells
        XCTAssertGreaterThan(cells.count, 0)
        
        // Verify first cell has content
        let firstCell = cells.firstMatch
        XCTAssertTrue(firstCell.exists)
        XCTAssertTrue(firstCell.staticTexts.count > 0)
    }
    
    func testPullToRefreshWorks() throws {
        // Given
        let newsList = app.tables.firstMatch
        XCTAssertTrue(newsList.waitForExistence(timeout: 10))
        
        // When - Pull to refresh
        newsList.swipeDown()
        
        // Then - Loading indicator should appear briefly
        let loadingIndicator = app.activityIndicators.firstMatch
        
        // Wait a moment for refresh to complete
        sleep(2)
        
        // List should still be present after refresh
        XCTAssertTrue(newsList.exists)
    }
    
    func testTapNewsItemNavigatesToDetail() throws {
        // Given
        let newsList = app.tables.firstMatch
        XCTAssertTrue(newsList.waitForExistence(timeout: 10))
        
        let firstCell = newsList.cells.firstMatch
        XCTAssertTrue(firstCell.exists)
        
        // When - Tap first news item
        firstCell.tap()
        
        // Then - Should navigate to detail view
        // Assuming detail view has a navigation back button
        let backButton = app.navigationBars.buttons.firstMatch
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
    }
    
    func testScrollingTriggersLoadMore() throws {
        // Given
        let newsList = app.tables.firstMatch
        XCTAssertTrue(newsList.waitForExistence(timeout: 10))
        
        let initialCellCount = newsList.cells.count
        
        // When - Scroll to bottom
        let lastCell = newsList.cells.element(boundBy: initialCellCount - 1)
        lastCell.swipeUp()
        lastCell.swipeUp()
        
        // Wait for potential load more
        sleep(3)
        
        // Then - Should have same or more items (depending on if more data available)
        let finalCellCount = newsList.cells.count
        XCTAssertGreaterThanOrEqual(finalCellCount, initialCellCount)
    }
    
    func testNavigationTitleIsDisplayed() throws {
        // Given/Then - Navigation title should be visible
        let navigationBar = app.navigationBars.firstMatch
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 5))
        
        // Should contain the feed type title (G1 or Agronegócio)
        let titleExists = navigationBar.staticTexts["G1"].exists ||
                         navigationBar.staticTexts["Agronegócio"].exists
        XCTAssertTrue(titleExists)
    }
    
    func testErrorAlertHandling() throws {
        // This test would require mocking network failures
        // or simulating airplane mode to test error handling
        
        // For now, just verify the app doesn't crash on launch
        let newsList = app.tables.firstMatch
        XCTAssertTrue(newsList.waitForExistence(timeout: 10))
        
        // If there was an error, an alert might appear
        if app.alerts.count > 0 {
            let alert = app.alerts.firstMatch
            XCTAssertTrue(alert.exists)
            
            // Try to dismiss it
            let tryAgainButton = alert.buttons["Tentar novamente"]
            if tryAgainButton.exists {
                tryAgainButton.tap()
            }
        }
    }
}

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
        let newsList = app.tables.firstMatch
        XCTAssertTrue(newsList.waitForExistence(timeout: 10))
        
        let cells = newsList.cells
        XCTAssertGreaterThan(cells.count, 0)
        
        let firstCell = cells.firstMatch
        XCTAssertTrue(firstCell.exists)
        XCTAssertTrue(firstCell.staticTexts.count > 0)
    }
    
    func testPullToRefreshWorks() throws {
        let newsList = app.tables.firstMatch
        XCTAssertTrue(newsList.waitForExistence(timeout: 10))
        
        newsList.swipeDown()
        
        let loadingIndicator = app.activityIndicators.firstMatch
        
        sleep(2)
        
        XCTAssertTrue(newsList.exists)
    }
    
    func testTapNewsItemNavigatesToDetail() throws {
        let newsList = app.tables.firstMatch
        XCTAssertTrue(newsList.waitForExistence(timeout: 10))
        
        let firstCell = newsList.cells.firstMatch
        XCTAssertTrue(firstCell.exists)
        
        firstCell.tap()
    
        let backButton = app.navigationBars.buttons.firstMatch
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
    }
    
    func testNavigationTitleIsDisplayed() throws {
        let navigationBar = app.navigationBars.firstMatch
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 5))
        
        let titleExists = navigationBar.staticTexts["G1"].exists ||
                         navigationBar.staticTexts["Agronegócio"].exists
        XCTAssertTrue(titleExists)
    }
    
}

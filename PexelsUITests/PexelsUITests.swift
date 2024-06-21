//
//  PexelsUITests.swift
//  PexelsUITests
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import XCTest

/// UI tests for the Pexels application.
class PexelsUITests: XCTestCase {

    /// Tests that the content view displays videos.
    func testContentViewDisplaysVideos() throws {
        let app = XCUIApplication()
        app.launch()

        // Wait for the first cell to exist
        let firstCell = app.tables.cells.firstMatch
        let exists = NSPredicate(format: "exists == true")

        expectation(for: exists, evaluatedWith: firstCell, handler: nil)
        waitForExpectations(timeout: 20, handler: nil)
        
        XCTAssertTrue(firstCell.exists, "The first video cell should exist")

        firstCell.tap()
        
        let videoTitle = app.staticTexts["videoTitle_1"]
        expectation(for: exists, evaluatedWith: videoTitle, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(videoTitle.exists, "The video title should be visible")
    }
}

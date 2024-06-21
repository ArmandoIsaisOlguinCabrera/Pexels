//
//  PexelsUITests.swift
//  PexelsUITests
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import XCTest

final class PexelsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testContentViewDisplaysVideos() throws {
        let app = XCUIApplication()
        app.launch()

        // Asegúrate de que la primera celda existe
        let firstCell = app.cells.matching(identifier: "videoCell_").firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 20), "The first video cell should exist")

        // Tap en la primera celda
        firstCell.tap()
        
        // Asegúrate de que el título del video existe en la vista de detalle
        let videoDuration = app.staticTexts["videoDuration"]
        XCTAssertTrue(videoDuration.waitForExistence(timeout: 10), "The video duration should be visible")
    }
}


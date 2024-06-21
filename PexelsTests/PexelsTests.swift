//
//  PexelsTests.swift
//  PexelsTests
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import XCTest
import RealmSwift
@testable import Pexels

/// Unit tests for the Pexels application.
class PexelsTests: XCTestCase {

    var realm: Realm!
    var realmManager: RealmManager!
    var mockService: MockAPIService!

    /// Sets up the test environment.
    override func setUpWithError() throws {
        try super.setUpWithError()
        var config = Realm.Configuration()
        config.inMemoryIdentifier = self.name
        realm = try Realm(configuration: config)
        realmManager = RealmManager(realm: realm)
        mockService = MockAPIService()
    }

    /// Tears down the test environment.
    override func tearDownWithError() throws {
        realm = nil
        realmManager = nil
        mockService = nil
        try super.tearDownWithError()
    }

    /// Tests fetching videos using the mock service.
    func testFetchVideos() async throws {
        let videos = try await mockService.fetchVideos(query: "nature")
        XCTAssertFalse(videos.isEmpty, "Fetched videos should not be empty")
    }

    /// Tests saving and loading videos in Realm.
    func testSaveAndLoadVideos() {
        let videos = [Video(id: 1, width: 1920, height: 1080, url: "https://example.com", image: "https://example.com/image.jpg", duration: 120, user: User(id: 1, name: "User", url: "https://example.com"), videoFiles: [], videoPictures: [])]
        realmManager.saveVideos(videos)
        let loadedVideos = realmManager.loadVideos()
        XCTAssertEqual(videos.count, loadedVideos.count, "Loaded videos should match the saved videos")
    }
}

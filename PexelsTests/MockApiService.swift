//
//  MockApiService.swift
//  PexelsTests
//
//  Created by Armando Isais Olguin Cabrera  on 21/06/24.
//

import Foundation

/// Simulated implementation of APIService for unit testing.
class MockAPIService: APIService {
    /// Simulates fetching videos from the Pexels API.
    /// - Parameter query: The search query for videos.
    /// - Returns: An array of simulated video objects.
    override func fetchVideos(query: String) async throws -> [Video] {
        return [
            Video(id: 1, width: 1920, height: 1080, url: "https://example.com", image: "https://example.com/image.jpg", duration: 120, user: User(id: 1, name: "User", url: "https://example.com"), videoFiles: [], videoPictures: [])
        ]
    }
}

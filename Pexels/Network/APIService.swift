//
//  APIService.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import Foundation

/// Class responsible for making requests to the Pexels API to fetch videos.
class APIService {
    private let apiKey = "rSdWyv4EFY2o0VIJgzKPXUMCqMy2B6NidX4zKQQ4cxHbsmU2b7kwJdLy"

    /// Asynchronously performs a request to fetch videos based on the provided query.
    /// - Parameter query: The search query for videos.
    /// - Returns: An array of `Video` objects.
    func fetchVideos(query: String) async throws -> [Video] {
        let urlString = "https://api.pexels.com/videos/search?query=\(query)&per_page=30"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(PexelsResponse.self, from: data)
        return response.videos
    }
}


struct PexelsResponse: Decodable {
    let videos: [Video]
}

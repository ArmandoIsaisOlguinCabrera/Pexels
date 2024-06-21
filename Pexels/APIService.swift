//
//  APIService.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import Foundation

class APIService {
    private let apiKey = "rSdWyv4EFY2o0VIJgzKPXUMCqMy2B6NidX4zKQQ4cxHbsmU2b7kwJdLy"
    private let baseURL = "https://api.pexels.com/v1/"
    
    func fetchVideos(query: String) async throws -> [Video] {
            let url = URL(string: "\(baseURL)videos/search?query=\(query)")!
            var request = URLRequest(url: url)
            request.setValue(apiKey, forHTTPHeaderField: "Authorization")

            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(PexelsResponse.self, from: data)
            return response.videos
        }
}

struct PexelsResponse: Decodable {
    let videos: [Video]
    
    private enum CodingKeys: String, CodingKey {
        case videos = "videos"
    }
}


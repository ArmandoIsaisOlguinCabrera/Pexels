//
//  APIService.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import Foundation
import Combine

class APIService {
    private let apiKey = "rSdWyv4EFY2o0VIJgzKPXUMCqMy2B6NidX4zKQQ4cxHbsmU2b7kwJdLy"

    func fetchVideos(query: String) -> AnyPublisher<[Video], Error> {
        let urlString = "https://api.pexels.com/videos/search?query=\(query)&per_page=10"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: PexelsResponse.self, decoder: JSONDecoder())
            .map(\.videos)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct PexelsResponse: Decodable {
    let videos: [Video]
    
    private enum CodingKeys: String, CodingKey {
        case videos = "videos"
    }
}


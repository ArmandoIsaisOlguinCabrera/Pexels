//
//  VideoViewModel.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 21/06/24.
//

import Combine
import SwiftUI

class VideoViewModel: ObservableObject {
    @Published var videos: [Video] = []
    @Published var isConnected: Bool = true
    private var cancellables = Set<AnyCancellable>()

    private let service: APIService
    private let networkMonitor: NetworkMonitor

    init(service: APIService = APIService(), networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.service = service
        self.networkMonitor = networkMonitor
        self.networkMonitor.$isConnected
            .assign(to: \.isConnected, on: self)
            .store(in: &cancellables)
    }

    func fetchVideos() {
        service.fetchVideos(query: "nature")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching videos: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] videos in
                self?.videos = videos
                // Save to Realm for offline persistence
                RealmManager.shared.saveVideos(videos)
            })
            .store(in: &cancellables)
    }
}

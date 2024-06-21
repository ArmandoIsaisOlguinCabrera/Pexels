//
//  VideoViewModel.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 21/06/24.
//

import SwiftUI
import Combine

/// ViewModel to manage video data and network connectivity.
class VideoViewModel: ObservableObject {
    @Published var videos: [Video] = []
    @Published var isConnected: Bool = true
    private var cancellables = Set<AnyCancellable>()

    private let service: APIService
    let networkMonitor: NetworkMonitor

    /// Initializes a new instance of `VideoViewModel`.
    /// - Parameters:
    ///   - service: Instance of `APIService` to fetch videos.
    ///   - networkMonitor: Instance of `NetworkMonitor` to monitor network connectivity.
    init(service: APIService = APIService(), networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.service = service
        self.networkMonitor = networkMonitor
        self.networkMonitor.$isConnected
            .assign(to: \.isConnected, on: self)
            .store(in: &cancellables)
    }

    /// Performs the request to fetch videos from the API and saves them to Realm database.
    func fetchVideos() {
        Task {
            do {
                let videos = try await service.fetchVideos(query: "nature")
                DispatchQueue.main.async {
                    self.videos = videos
                    RealmManager.shared.saveVideos(videos)
                }
            } catch {
                print("Error fetching videos: \(error.localizedDescription)")
            }
        }
    }
}

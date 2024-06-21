//
//  ContentView.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var videos: [Video] = []

    var body: some View {
        NavigationView {
            List(videos) { video in
                NavigationLink(destination: DetailView(video: video)) {
                    VStack(alignment: .leading) {
                        Text(video.user.name)
                            .font(.headline)
                        Text("Duración: \(video.duration) segundos")
                            .font(.subheadline)
                        AsyncImage(url: URL(string: video.image)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width - 32, height: 200)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("Videos de Pexels")
            .onAppear {
                Task {
                    await fetchVideos()
                }
            }
        }
    }

    private func fetchVideos() async {
        // Intentar cargar desde Realm primero
        videos = RealmManager.shared.loadVideos()
        if videos.isEmpty {
            // Si no hay datos en Realm, cargar desde la API
            let service = APIService()
            do {
                let fetchedVideos = try await service.fetchVideos(query: "nature")
                self.videos = fetchedVideos
                // Guardar los videos en Realm para persistencia offline
                RealmManager.shared.saveVideos(fetchedVideos)
            } catch {
                print("Error fetching videos: \(error.localizedDescription)")
            }
        }
    }
}

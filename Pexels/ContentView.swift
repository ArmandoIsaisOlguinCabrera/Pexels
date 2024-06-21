//
//  ContentView.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = VideoViewModel()

    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.videos) { video in
                    NavigationLink(destination: DetailView(video: video)) {
                        VideoRow(video: video)
                            .accessibilityIdentifier("videoCell_\(video.id)") // Agrega un identificador de accesibilidad
                    }
                }
                .navigationTitle("Videos")
            }
            if !viewModel.networkMonitor.isConnected {
                NetworkStatusView()
                    .padding()
                    .transition(.slide)
                    .animation(.easeInOut, value: viewModel.networkMonitor.isConnected)
            }
        }
        .onAppear {
            viewModel.fetchVideos()
        }
    }
}

struct VideoRow: View {
    let video: Video

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: video.image)) { image in
                image.resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(video.user.name)
                    .font(.headline)
                    .accessibilityIdentifier("videoTitle_\(video.id)") // Agrega un identificador de accesibilidad
                Text("Duration: \(video.duration) seconds")
                    .font(.subheadline)
            }
        }
    }
}

struct NetworkStatusView: View {
    var body: some View {
        Text("No Internet Connection")
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(8)
    }
}

//
//  ContentView.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import SwiftUI

/// The main content view displaying a list of videos.
struct ContentView: View {
    /// The view model responsible for managing video data.
    @StateObject private var viewModel = VideoViewModel()

    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.videos) { video in
                    NavigationLink(destination: DetailView(video: video)) {
                        VideoRow(video: video)
                            .accessibilityIdentifier("videoCell_\(video.id)")
                    }
                }
                .navigationTitle("Videos")
            }
            
            // Network Status Indicator
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

/// A view representing a single row in the video list.
struct VideoRow: View {
    /// The video object to display in the row.
    let video: Video

    var body: some View {
        HStack {
            // Video Thumbnail
            AsyncImage(url: URL(string: video.image)) { image in
                image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
            }
            
            // Video Details
            VStack(alignment: .leading) {
                Text(video.user.name)
                    .font(.headline)
                    .accessibilityIdentifier("videoTitle_\(video.id)") // Accessibility identifier for video title
                Text("Duration: \(video.duration) seconds")
                    .font(.subheadline)
            }
        }
    }
}

/// A view indicating the network status.
struct NetworkStatusView: View {
    var body: some View {
        Text("No Internet Connection")
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(8)
    }
}

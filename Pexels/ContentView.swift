//
//  ContentView.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = VideoViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isConnected {
                    List(viewModel.videos) { video in
                        NavigationLink(destination: DetailView(video: video)) {
                            VideoRow(video: video)
                        }
                    }
                    .onAppear {
                        viewModel.fetchVideos()
                    }
                } else {
                    Text("No Internet Connection")
                }
            }
            .navigationTitle("Videos")
        }
    }
}

struct VideoRow: View {
    let video: Video

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: video.image))
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(video.user.name)
                    .font(.headline)
                Text("Duration: \(video.duration) seconds")
                    .font(.subheadline)
            }
        }
    }
}

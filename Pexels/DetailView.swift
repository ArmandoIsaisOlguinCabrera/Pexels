//
//  DetailView.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import SwiftUI
import AVKit

struct DetailView: View {
    let video: Video

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: video.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
            } placeholder: {
                ProgressView()
            }

            Text("Duración: \(video.duration) segundos")
                .font(.headline)
                .padding()

            if let videoURL = URL(string: video.videoFiles.first?.link ?? "") {
                VideoPlayerContainerView(videoURL: videoURL)
                    .frame(height: 300)
            } else {
                Text("Video URL is invalid")
                    .foregroundColor(.red)
            }

            Spacer()
        }
        .navigationTitle(video.user.name)
    }
}

struct RemoteImageView: View {
    let url: String

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
    }
}

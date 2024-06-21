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
    @State private var player: AVPlayer?

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: video.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
            } placeholder: {
                ProgressView()
            }

            Text("Duration: \(video.duration) seconds")
                .font(.headline)
                .padding()
                .accessibilityIdentifier("videoDuration")

            Button(action: {
                guard let videoFile = video.videoFiles.first(where: { $0.quality == "hd" }) else { return }
                player = AVPlayer(url: URL(string: videoFile.link)!)
                player?.play()
            }) {
                Text("Play Video")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            if let player = player {
                VideoPlayer(player: player)
                    .frame(height: 300)
                    .accessibilityIdentifier("videoPlayer")
            }

            Spacer()
        }
        .navigationTitle(video.user.name)
        .onDisappear {
            player?.pause()
        }
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

//
//  DetailView.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import SwiftUI
import AVKit

/// A detailed view displaying information about a specific video.
struct DetailView: View {
    /// The video object to display details for.
    let video: Video
    
    /// The AVPlayer instance used for video playback.
    @State private var player: AVPlayer?

    var body: some View {
        VStack(spacing: 16) {
            // Video Thumbnail
            AsyncImage(url: URL(string: video.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .clipped() // Ensure the image doesn't exceed its bounds
            } placeholder: {
                ProgressView()
            }

            // Video Duration
            Text("Duration: \(video.duration) seconds")
                .font(.headline)
                .padding()
                .accessibilityIdentifier("videoDuration")

            // Play Button
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

            // Video Player
            if let player = player {
                VideoPlayer(player: player)
                    .frame(height: 300)
                    .accessibilityIdentifier("videoPlayer")
            }

            Spacer()
        }
        .navigationTitle(video.user.name) // Set navigation title to the name of the video user
        .onDisappear {
            player?.pause() // Pause video playback when view disappears
        }
    }
}

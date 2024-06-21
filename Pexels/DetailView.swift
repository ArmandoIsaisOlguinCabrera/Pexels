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

            Text("Duración: \(video.duration) segundos")
                .font(.headline)
                .padding()

            Button(action: {
                guard let videoURL = URL(string: video.url) else { return }
                player = AVPlayer(url: videoURL)
                player?.play()
            }) {
                Text("Reproducir Video")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            Spacer()
        }
        .navigationTitle(video.user.name)
        .onDisappear {
            player?.pause()
        }
        .onAppear {
            player?.play()
        }
        .onDisappear {
            player?.pause()
        }
    }
}

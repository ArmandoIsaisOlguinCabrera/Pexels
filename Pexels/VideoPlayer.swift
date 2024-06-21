//
//  VideoPlayer.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 21/06/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoURL: URL
    
    var body: some View {
        VideoPlayer(player: AVPlayer(url: videoURL))
            .onAppear {
                let player = AVPlayer(url: videoURL)
                player.play()
            }
    }
}

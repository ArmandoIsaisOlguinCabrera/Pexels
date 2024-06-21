//
//  VideoPlayerContainerView.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 21/06/24.
//

import SwiftUI
import AVKit

struct VideoPlayerContainerView: UIViewControllerRepresentable {
    let videoURL: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let player = AVPlayer(url: videoURL)
        controller.player = player
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}

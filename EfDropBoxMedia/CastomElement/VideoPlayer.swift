//
//  VideoPlayer.swift
//  EfDropBoxMedia
//
//  Created by user on 10.09.2023.
//

import UIKit
import AVFoundation

class VideoPlayer: UIView {
    
    private let playerLayer: AVPlayerLayer
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    init(frame: CGRect, url: URL) {
        
        playerLayer = AVPlayerLayer()
        super.init(frame: frame)
        
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

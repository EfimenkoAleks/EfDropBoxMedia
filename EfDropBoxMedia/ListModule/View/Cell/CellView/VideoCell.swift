//
//  VideoCell.swift
//  EfDropBoxMedia
//
//  Created by user on 11.09.2023.
//

import UIKit
import AVFoundation

class VideoCell: UITableViewCell, ReusableCell {
    
    @IBOutlet private weak var containerForContentView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var widthConstraint: NSLayoutConstraint!
    
    var viewModel: ListCellViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUI()
    }
    
    func configure(model: List) {
        if viewModel == nil {
            viewModel = ListCellViewModel()
        }
        if let path = model.pathLower {
            viewModel?.downLoad(path) { [unowned self] result in
                switch result {
                case .loaded(let path):
                    setVideo(path: path, name: model.name)
                default:
                    break
                }
            }
        }
    }
    
    private func setVideo(path: String, name: String?) {
        
        guard let url = viewModel?.getUrlForVideo(path: path) else { return }
        let videoView = VideoPlayer(frame: containerForContentView.bounds, url: url)
        videoView.translatesAutoresizingMaskIntoConstraints = false
        containerForContentView.subviews.forEach({ $0.removeFromSuperview()})
        containerForContentView.addSubview(videoView)

        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: containerForContentView.topAnchor),
            videoView.leadingAnchor.constraint(equalTo: containerForContentView.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: containerForContentView.trailingAnchor),
            videoView.bottomAnchor.constraint(equalTo: containerForContentView.bottomAnchor)
        ])

        videoView.player?.play()
        nameLabel.text = viewModel?.removeEnding(name: name)
    }
    
    private func configUI() {
        containerForContentView.layer.cornerRadius = 10
        containerForContentView.layer.masksToBounds = true
    }
}

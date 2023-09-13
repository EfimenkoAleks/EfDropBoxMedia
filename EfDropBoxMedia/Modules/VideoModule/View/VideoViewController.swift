//
//  VideoViewController.swift
//  EfDropBoxMedia
//
//  Created by user on 12.09.2023.
//

import UIKit

class VideoViewController: UIViewController {
    
    // MARK: — properties
    
    var coordinator: VideoCoordinatorProtocol?
    
    private var path: String?
    
    lazy var viewModel: VideoViewModelProtocol = {
        let viewModel = VideoViewModel()
        return viewModel
    }()
    
    // MARK: — lifecycle

        init(with path: String?) {
            self.path = path
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private weak var containerVideoView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var modifiedLabel: UILabel!
    @IBOutlet private weak var sizeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindUI()
    }
    
    deinit {
        coordinator?.handlerBack?()
    }
}

// MARK: — private fanc

private extension VideoViewController {
    
    func bindUI() {
        viewModel.fetchVideo = { result in
            DispatchQueue.main.async { [weak self] in
                if let video = result {
                    self?.configureUI(model: video)
                }
            }
        }
        if let path = self.path {
            viewModel.fechData(path: path)
        }
    }
    
    func configureUI(model: PhotoModel?) {
        guard let model = model else { return }
        
        setVideo(path: model.pathLower ?? "")
        nameLabel.text = viewModel.trimName(name: model.name)
        modifiedLabel.text = Date.convertDateToString(date: model.modified)
        sizeLabel.text = viewModel.convertToMB(size: model.size)
    }
    
    func setVideo(path: String) {
        
        guard let url = viewModel.getUrlForVideo(path: path) else { return }
        let videoView = VideoPlayer(frame: containerVideoView.bounds, url: url)
        videoView.translatesAutoresizingMaskIntoConstraints = false
        containerVideoView.subviews.forEach({ $0.removeFromSuperview()})
        containerVideoView.addSubview(videoView)

        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: containerVideoView.topAnchor),
            videoView.leadingAnchor.constraint(equalTo: containerVideoView.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: containerVideoView.trailingAnchor),
            videoView.bottomAnchor.constraint(equalTo: containerVideoView.bottomAnchor)
        ])

        videoView.player?.play()
    }
}

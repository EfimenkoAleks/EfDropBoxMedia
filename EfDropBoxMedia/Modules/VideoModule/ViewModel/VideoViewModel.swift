//
//  VideoViewModel.swift
//  EfDropBoxMedia
//
//  Created by user on 12.09.2023.
//

import Foundation

class VideoViewModel {
    
    var fetchVideo: ((PhotoModel?) -> Void)?
    private var _fetcher: DetailFetcherProtocol
    private let helper: VideoHelper = VideoHelper()
    
    init(fetcher: DetailFetcherProtocol = DIContainer.default.detailService) {
        self._fetcher = fetcher
    }
}

extension VideoViewModel: VideoViewModelProtocol {
    
    func fechData(path: String) {
        _fetcher.downLoadVideo(path: path) { [weak self] result in
            switch result {
            case .loadedVideo(let model):
                self?.fetchVideo?(model)
            default:
                self?.fetchVideo?(nil)
            }
        }
    }
    
    func trimName(name: String) -> String {
        helper.trimName(name)
    }
    
    func convertToMB(size: Int64) -> String {
        helper.convertToMB(size: size)
    }
    
    func getUrlForVideo(path: String) -> URL? {
        helper.getUrlForVideo(path: path)
    }
}

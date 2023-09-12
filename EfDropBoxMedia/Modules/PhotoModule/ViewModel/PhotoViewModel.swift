//
//  PhotoViewModel.swift
//  EfDropBoxMedia
//
//  Created by user on 12.09.2023.
//

import UIKit

class PhotoViewModel {
    
    var fetchPhoto: ((PhotoModel?) -> Void)?
    private var _fetcher: DetailFetcherProtocol
    private let helper: PhotoHelper = PhotoHelper()
    
    init(fetcher: DetailFetcherProtocol = DIContainer.default.detailService) {
        self._fetcher = fetcher
    }
}

extension PhotoViewModel: PhotoViewModelProtocol {
    
    func fechData(path: String) {
        _fetcher.downLoadPhoto(path: path) { [weak self] result in
            switch result {
            case .loadedPhoto(let photo):
                self?.fetchPhoto?(photo)
            default:
                self?.fetchPhoto?(nil)
            }
        }
    }
    
    func getImage(path: String?) -> UIImage? {
        helper.getImage(path: path)
    }
    
    func trimSlash(name: String) -> String {
        helper.removeEnding(name)
    }
    
    func convertToMB(size: Int64) -> String {
        helper.convertToMB(size: size)
    }
}

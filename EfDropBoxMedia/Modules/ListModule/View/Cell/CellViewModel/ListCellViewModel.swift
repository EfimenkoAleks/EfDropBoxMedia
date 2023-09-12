//
//  ListCellViewModel.swift
//  EfDropBoxMedia
//
//  Created by user on 09.09.2023.
//

import UIKit

class ListCellViewModel {
    
    var fetch: ((DownLoad) -> Void)?
    private var _fetcher: ListFetcherProtocol
    private let helper: ListHelper = ListHelper()
    
    init(fetcher: ListFetcherProtocol = DIContainer.default.listService) {
        self._fetcher = fetcher
    }
}

extension ListCellViewModel: ListCellViewModelProtocol {
    func downLoad(_ path: String, completion: @escaping (DownLoad) -> Void) {
        let content = helper.defineContent(str: path)
        switch content {
        case .video:
            _fetcher.downLoadVideo(path: path) { result in
                completion(result)
            }
        case .photo:
            _fetcher.downLoad(path: path) { result in
                completion(result)
            }
        case .notSupported:
            completion(.notSupported)
        }
    }
    
    func getUrlForVideo(path: String) -> URL? {
        helper.getUrlForVideo(path: path)
    }
    
    func removeEnding(name: String?) -> String {
        helper.removeEnding(name)
    }
    
    func getImageFromPath(_ path: String) -> UIImage? {
        helper.getImage(name: path)
    }
    
    func newWidth(image: UIImage, height: CGFloat) -> CGFloat {
        helper.newWidthImage(image, myViewHeight: height)
    }
    
    func removeEndingFrom(_ str: String?) -> String {
        helper.removeEnding(str)
    }
}

protocol ListCellViewModelProtocol {
    var fetch: ((DownLoad) -> Void)? {get set}
    func downLoad(_ path: String, completion: @escaping (DownLoad) -> Void)
    func getUrlForVideo(path: String) -> URL?
    func removeEnding(name: String?) -> String
    func getImageFromPath(_ path: String) -> UIImage?
    func newWidth(image: UIImage, height: CGFloat) -> CGFloat
    func removeEndingFrom(_ str: String?) -> String
}

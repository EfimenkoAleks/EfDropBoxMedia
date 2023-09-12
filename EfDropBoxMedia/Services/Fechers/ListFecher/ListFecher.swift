//
//  ListFecher.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import Foundation

class ListFetcher: ListFetcherProtocol {
    
    private let folder: String = ""
    private var isFirstRequest: Bool = true
    private let networkService: NetWorkServiceProtocol = NetWorkService()
    private var cursor: String?
    
    func getList(completion: @escaping ([List]) -> Void) {
        if let cursor = cursor {
            networkService.getListContinue(cursor: cursor) { [weak self] result in
                switch result {
                case .success(let object):
                    self?.cursor = object.cursor
                    completion(object.listModels)
                case .failure(_):
                    completion([])
                }
            }
        } else {
            networkService.getList(path: folder) { [weak self] result in
                switch result {
                case .success(let object):
                    self?.cursor = object.cursor
                    completion(object.listModels)
                case .failure(_):
                    completion([])
                }
            }
        }
    }
    
    func downLoad(path: String, completion: @escaping (DownLoad) -> Void) {
        networkService.downLoadPreviewPhoto(path: (folder + path)) { result in
            completion(result)
        }
    }
    
    func downLoadVideo(path: String, completion: @escaping (DownLoad) -> Void) {
        networkService.download(path: path) { result in
            completion(result)
        }
    }
}

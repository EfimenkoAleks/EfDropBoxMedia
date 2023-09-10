//
//  ListFecher.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import Foundation

enum DownLoad {
    case startDownloading
    case loaded(String)
    case error
}

class ListFecher: ListFecherProtocol {
    
    private let folder: String = ""
    private var isFirstRequest: Bool = true
    private let networkService: ListNetWorkServiceProtocol = ListNetWorkService()
    private let preferences: PreferencesProtocol = Preferences()
    private var cursor: String?
    
    func getList(completion: @escaping ([String]) -> Void) {
        if let cursor = cursor {
            networkService.getListContinue(cursor: cursor) { [weak self] result in
                switch result {
                case .success(let object):
                    self?.cursor = object.cursor
                    completion(object.pathLowers)
                case .failure(_):
                    completion([])
                }
            }
        } else {
            networkService.getList(path: folder) { [weak self] result in
                switch result {
                case .success(let object):
                    self?.cursor = object.cursor
                    completion(object.pathLowers)
                case .failure(_):
                    completion([])
                }
            }
        }
    }
    
    func downLoad(path: String, isPreview: Bool, completion: @escaping (DownLoad) -> Void) {
        if isPreview {
            networkService.downLoadPreviewPhoto(path: (folder + path)) { result in
                completion(result)
            }
        } else {
            networkService.downLoadPhoto(path: (folder + path)) { result in
                completion(result)
            }
        }
    }
}

//
//  DetailFetcher.swift
//  EfDropBoxMedia
//
//  Created by user on 10.09.2023.
//

import Foundation

class DetailFetcher: DetailFetcherProtocol {
    
    private let networkService: NetWorkServiceProtocol = NetWorkService()
    
    func downLoadPhoto(path: String, completion: @escaping (String) -> Void) {
        
       let bigPath = createBigPathFromPath(path)
        networkService.downLoadPhoto(path: path, pathForSaveBig: bigPath) { result in
            switch result {
            case .loaded(let path):
                completion(path)
            default:
                break
            }
        }
    }
    
    func getPath(path: String, completion: @escaping (String) -> Void) {
        
        networkService.download(path: path) { result in
            switch result {
            case .loaded(let path):
                completion(path)
            default:
                break
            }
        }
    }
    
    private func createBigPathFromPath(_ path: String) -> String {
        let editedPath = path.replacingOccurrences(of: "/", with: "")
        let savedPath = "big" + editedPath
        return savedPath
    }
}

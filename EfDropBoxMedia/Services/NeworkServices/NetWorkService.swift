//
//  NetWorkService.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import Foundation
import SwiftyDropbox

class NetWorkService: NetWorkServiceProtocol {
    
    private let fileManager = FileManager.default
    private var client: DropboxClient? {
        get {
            return DropboxClientsManager.authorizedClient
        }
    }
    
    init() {
    }
    
    func getList(path: String, completion: @escaping (Result<ListObject, Error>) -> Void) {
        
        client?.files.listFolder(path: path).response { response, error in
            if let result = response {
                
                let arrayPathLower: [List] = result.entries.compactMap { object -> List in
                    List(pathLower: object.pathLower, name: object.name)
                }
                let object = ListObject(cursor: result.cursor, listModels: arrayPathLower)
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error as! Error))
            }
        }
    }
    
    func getListContinue(cursor: String, completion: @escaping (Result<ListObject, Error>) -> Void) {
        client?.files.listFolderContinue(cursor: cursor).response { response, error in
            if let result = response {
                let arrayPathLower: [List] = result.entries.compactMap { object -> List in
                    List(pathLower: object.pathLower, name: object.name)
                }
                let object = ListObject(cursor: result.cursor, listModels: arrayPathLower)
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error as! Error))
            }
        }
    }
    
    private func containsVideoOfPath(_ path: String) -> Data? {
        
        guard let fileURL = getFileUrlFromPath(path) else { return nil }
        do {
            let imageData = try Data(contentsOf: fileURL as URL)
            return imageData
        } catch {
            return nil
        }
    }
    
    func download(path: String, completion: @escaping (DownLoad) -> Void) {
        
        guard let fileURL = getFileUrlFromPath(path) else { return }
        guard containsVideoOfPath(path) == nil else {
            completion(.loaded(path))
            return
        }
        let destination: (URL, HTTPURLResponse) -> URL = { temporaryURL, response in
            return fileURL
        }
        
        client?.files.download(path: path, overwrite: true, destination: destination)
            .response { response, error in
                if let response = response {
                    if let path = response.0.pathLower {
                        completion(.loaded(path))
                    }
                } else if error != nil {
                    completion(.error)
                }
            }
    }
    
    func downLoadPhoto(path: String, pathForSaveBig: String, completion: @escaping (DownLoad) -> Void) {
        
        guard self.getImage(path: pathForSaveBig) == nil else {
            completion(.loaded(pathForSaveBig))
            return
        }
        client?.files.download(path: path)
            .response { [unowned self] response, error in
                if let response = response, response.0.pathLower != nil {
                    completion(saveData(response.1, path: pathForSaveBig))
                } else if error != nil {
                    completion(.error)
                }
            }
    }
    
    func downLoadPreviewPhoto(path: String, completion: @escaping (DownLoad) -> Void) {
        
        guard self.getImage(path: path) == nil else {
            completion(.loaded(path))
            return
        }
        client?.files.getThumbnail(path: path, size: .w256h256)
            .response { [unowned self] response, error in
                if let response = response, response.0.pathLower != nil {
                    completion(saveData(response.1, path: path))
                }
                if error != nil {
                    completion(.error)
                    return
                }
            }
    }
    
    private func getFileUrlFromPath(_ path: String) -> URL? {
        
        guard let documentsDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil}
        let fileURL = documentsDirectory.appendingPathComponent(path)
        return fileURL
    }
    
    private func saveData(_ data: Data, path: String) -> DownLoad {
        
        guard let fileURL = getFileUrlFromPath(path) else { return .error }
        if
            !fileManager.fileExists(atPath: fileURL.path) {
            do {
                try data.write(to: fileURL)
                return .loaded(path)
            } catch {
                return .error
            }
        } else if fileManager.fileExists(atPath: fileURL.path) {
            return .error
        } else {  return .error }
    }
    
    private func getImage(path: String) -> UIImage? {
        
        guard let fileURL = getFileUrlFromPath(path) else { return nil }
        let image = UIImage(contentsOfFile: fileURL.path)
        return image
    }
}

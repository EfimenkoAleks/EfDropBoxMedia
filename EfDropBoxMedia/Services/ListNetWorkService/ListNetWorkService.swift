//
//  ListNetWorkService.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import Foundation
import SwiftyDropbox

class ListNetWorkService: ListNetWorkServiceProtocol {
    
    private let appKey: String = "edsgfk9aucuex08"
    private let appSecret: String = "mxp2qc34buy7rvs"
    private let sesion = URLSession.shared
    private let preferences: PreferencesProtocol = Preferences()
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
    
    func downLoadPhoto(path: String, completion: @escaping (DownLoad) -> Void) {
        let editedPath = path.replacingOccurrences(of: "/", with: "")
        let savedPath = "big" + editedPath
        guard self.getImage(name: savedPath) == nil else {
            completion(.loaded(savedPath))
            return
        }
        client?.files.download(path: path)
            .response { response, error in
                if let response = response, response.0.pathLower != nil {
                
                    let image = UIImage(data: response.1)
                    let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
                    let fileURL = documentsDirectory.appendingPathComponent(savedPath)
                    if let data = image?.pngData(),
                       !FileManager.default.fileExists(atPath: fileURL.path) {
                        do {
                            try data.write(to: fileURL)
                            completion(.loaded(savedPath))
                        } catch {
                            completion(.error)
                        }
                    } else if FileManager.default.fileExists(atPath: fileURL.path) {
                        completion(.error)
                    }
                } else if error != nil {
                    completion(.error)
                }
            }
    }
    
    func downLoadPreviewPhoto(path: String, completion: @escaping (DownLoad) -> Void) {
        guard self.getImage(name: path) == nil else {
            completion(.loaded(path))
            return
        }
        client?.files.getThumbnail(path: path, size: .w256h256).response { response, error in
            if let response = response, response.0.pathLower != nil {
                let image = UIImage(data: response.1)
                let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent(path)
                if let data = image?.pngData(),
                   !FileManager.default.fileExists(atPath: fileURL.path) {
                    do {
                        try data.write(to: fileURL)
                        completion(.loaded(path))
                    } catch {
                        completion(.error)
                    }
                } else if FileManager.default.fileExists(atPath: fileURL.path) {
                    completion(.error)
                }
            }
            if error != nil {
              completion(.error)
            return
          }
        }
      }
    
    private func getImage(name: String) -> UIImage? {
        
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileName = name
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        let image = UIImage(contentsOfFile: fileURL.path)
        return image
    }
    
    private func refreshToken(completion: @escaping () -> Void) {
        
        guard let tokenURL = URL(string: "https://api.dropbox.com/oauth2/token") else { return }
        
        let refreshToken = preferences.getRefreshToken() ?? ""
        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        
        let params = "refresh_token=\(refreshToken)&grant_type=refresh_token&client_id=\(appKey)&client_secret=\(appSecret)"
        
        request.httpBody = params.description.data(using: .ascii)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    
                    let token = responseJSON["access_token"] as? String
                    let expiresIn = responseJSON["expires_in"] as? TimeInterval
                    
                    self?.setNewToken(accessToken: token, expiresIn: expiresIn)
                    completion()
                }
            }
        }.resume()
    }
    
    private func setNewToken(accessToken: String?, expiresIn: TimeInterval?) {
        preferences.saveAccessToken(accessToken ?? "")
    }
}

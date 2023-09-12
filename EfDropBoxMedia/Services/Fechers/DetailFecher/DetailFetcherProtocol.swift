//
//  DetailFetcherProtocol.swift
//  EfDropBoxMedia
//
//  Created by user on 10.09.2023.
//

import Foundation

protocol DetailFetcherProtocol {
    func downLoadVideo(path: String, completion: @escaping (DownLoad) -> Void)
    func downLoadPhoto(path: String, completion: @escaping (DownLoad) -> Void) 
}

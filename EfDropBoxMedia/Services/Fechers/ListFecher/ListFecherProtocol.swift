//
//  ListFecherProtocol.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import Foundation

protocol ListFetcherProtocol {
    func getList(completion: @escaping ([List]) -> Void)
    func downLoad(path: String, completion: @escaping (DownLoad) -> Void)
    func downLoadVideo(path: String, completion: @escaping (DownLoad) -> Void)
}

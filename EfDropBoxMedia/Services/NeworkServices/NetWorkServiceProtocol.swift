//
//  NetWorkServiceProtocol.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import Foundation

protocol NetWorkServiceProtocol {
    func getList(path: String, completion: @escaping (Result<ListObject, Error>) -> Void)
    func getListContinue(cursor: String, completion: @escaping (Result<ListObject, Error>) -> Void)
    func downLoadPreviewPhoto(path: String, completion: @escaping (DownLoad) -> Void)
    func downLoadPhoto(path: String, pathForSaveBig: String, completion: @escaping (DownLoad) -> Void)
    func download(path: String, completion: @escaping (DownLoad) -> Void)
}

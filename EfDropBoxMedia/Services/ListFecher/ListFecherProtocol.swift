//
//  ListFecherProtocol.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import Foundation

protocol ListFecherProtocol {
    func getList(completion: @escaping ([List]) -> Void)
    func downLoad(path: String, isPreview: Bool, completion: @escaping (DownLoad) -> Void)
}

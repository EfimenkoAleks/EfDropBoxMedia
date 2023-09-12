//
//  DetailFetcherProtocol.swift
//  EfDropBoxMedia
//
//  Created by user on 10.09.2023.
//

import Foundation

protocol DetailFetcherProtocol {
    func getPath(path: String, completion: @escaping (String) -> Void)
}

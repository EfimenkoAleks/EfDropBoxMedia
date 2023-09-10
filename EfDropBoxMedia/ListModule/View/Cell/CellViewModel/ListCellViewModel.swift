//
//  ListCellViewModel.swift
//  EfDropBoxMedia
//
//  Created by user on 09.09.2023.
//

import Foundation

class ListCellViewModel {
    
    var fetch: ((DownLoad) -> Void)?
    private var _fetcher: ListFecherProtocol
    
    init(fetcher: ListFecherProtocol = DIContainer.default.listService) {
        self._fetcher = fetcher
    }
    
   func downLoad(_ path: String, completion: @escaping (DownLoad) -> Void) {
        _fetcher.downLoad(path: path, isPreview: true) { result in
            completion(result)
        }
    }
}

extension ListCellViewModel: ListCellViewModelProtocol {}

protocol ListCellViewModelProtocol {
    var fetch: ((DownLoad) -> Void)? {get set}
    func downLoad(_ path: String, completion: @escaping (DownLoad) -> Void)
}

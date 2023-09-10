//
//  ListViewModel.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import Foundation

class ListViewModel {
    
    var fetchList: (([String]) -> Void)?
    private var _fetcher: ListFecherProtocol
    
    init(fetcher: ListFecherProtocol = DIContainer.default.listService) {
        self._fetcher = fetcher
        
        fechData()
    }
    
    private func fechData() {
        _fetcher.getList { [unowned self] rezult in
            self.fetchList?(rezult)
        }
    }
}

extension ListViewModel: ListViewModelProtocol {}

//
//  ListViewModel.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import Foundation

class ListViewModel {
    
    var fetchList: (([List]) -> Void)?
    private var dataSource: [List] = []
    private var _fetcher: ListFecherProtocol
    
    init(fetcher: ListFecherProtocol = DIContainer.default.listService) {
        self._fetcher = fetcher
        
        fechData()
    }
    
    func fechData() {
        _fetcher.getList { [unowned self] rezult in
            dataSource.append(contentsOf: rezult)
            fetchList?(dataSource)
        }
    }
}

extension ListViewModel: ListViewModelProtocol {}

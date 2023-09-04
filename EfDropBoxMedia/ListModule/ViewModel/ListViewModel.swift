//
//  ListViewModel.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import Foundation

class ListViewModel {
    
    var fetchList: (([String]) -> Void)?

    init() {
        
        fechData()
    }
    
    private func fechData() {

    }
}

extension ListViewModel: ListViewModelProtocol {}


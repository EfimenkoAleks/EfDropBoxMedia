//
//  ListInterfaces.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import Foundation

protocol ListViewModelProtocol {
    var fetchList: (([String]) -> Void)? {get set}
}

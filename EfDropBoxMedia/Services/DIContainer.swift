//
//  DIContainer.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import Foundation

struct DIContainer {

    static var `default` = Self()
    
    lazy var listService: ListFecherProtocol = ListFecher()
}


//
//  ListModel.swift
//  EfDropBoxMedia
//
//  Created by user on 05.09.2023.
//

import Foundation

struct ListObject {
    var hasMore: Bool
    var cursor: String?
    var listModels: [List]
}

struct List {
    var pathLower: String?
    var name: String?
}

enum ListType {
    case video
    case photo
    case notSupported
}

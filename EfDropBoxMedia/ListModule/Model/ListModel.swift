//
//  ListModel.swift
//  EfDropBoxMedia
//
//  Created by user on 05.09.2023.
//

import Foundation

struct ListObject {
    var cursor: String?
    var listModels: [List]
}

struct List {
    var pathLower: String?
    var name: String?
}

enum DownLoad {
    case startDownloading
    case loaded(String)
    case notSupported
    case error
}

enum ListType {
    case video
    case photo
    case notSupported
}

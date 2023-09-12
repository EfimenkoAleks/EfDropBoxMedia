//
//  VideoInterfaces.swift
//  EfDropBoxMedia
//
//  Created by user on 12.09.2023.
//

import Foundation

protocol VideoViewModelProtocol {
    var fetchVideo: ((PhotoModel?) -> Void)? { get set }
    func fechData(path: String)
    func trimName(name: String) -> String
    func convertToMB(size: Int64) -> String
    func getUrlForVideo(path: String) -> URL?
}

//
//  PhotoInterfaces.swift
//  EfDropBoxMedia
//
//  Created by user on 12.09.2023.
//

import UIKit

protocol PhotoViewModelProtocol {
    var fetchPhoto: ((PhotoModel?) -> Void)? { get set }
    func fechData(path: String)
    func getImage(path: String?) -> UIImage?
    func trimSlash(name: String) -> String
    func convertToMB(size: Int64) -> String
}

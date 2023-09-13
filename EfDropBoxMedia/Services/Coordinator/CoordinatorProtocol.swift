//
//  CoordinatorProtocol.swift
//  EfDropBoxMedia
//
//  Created by user on 13.09.2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var cildren: [Coordinator] { get set }
}

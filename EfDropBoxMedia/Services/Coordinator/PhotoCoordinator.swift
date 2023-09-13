//
//  PhotoCoordinator.swift
//  EfDropBoxMedia
//
//  Created by user on 13.09.2023.
//

import UIKit

enum PhotoCoordinatorEvent {
    case back
}

protocol PhotoCoordinatorProtocol: Coordinator {
    var handlerBack: (() -> Void)? { get set }
    func start(path: String?)
    func eventOccurred(with type: PhotoCoordinatorEvent)
}

class PhotoCoordinator: PhotoCoordinatorProtocol {
    var cildren: [Coordinator] = []
    
    var navigationController: UINavigationController?
    var handlerBack: (() -> Void)?
    
    func start(path: String?) {
        let vc = PhotoViewController(with: path)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhotoCoordinator {
    func eventOccurred(with type: PhotoCoordinatorEvent) {
        switch type {
        case .back:
            navigationController?.popToRootViewController(animated: true)
            cildren.removeLast()
        }
    }
}

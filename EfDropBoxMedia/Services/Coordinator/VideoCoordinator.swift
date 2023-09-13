//
//  VideoCoordinator.swift
//  EfDropBoxMedia
//
//  Created by user on 13.09.2023.
//

import UIKit

enum VideoCoordinatorEvent {
    case back
}

protocol VideoCoordinatorProtocol: Coordinator {
    func start(path: String?)
    func eventOccurred(with type: VideoCoordinatorEvent)
    var handlerBack: (() -> Void)? { get set }
}

class VideoCoordinator: VideoCoordinatorProtocol {
    var cildren: [Coordinator] = []
    
    var navigationController: UINavigationController?
    var handlerBack: (() -> Void)?
    
    func start(path: String?) {
        let vc = VideoViewController(with: path)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension VideoCoordinator {
    func eventOccurred(with type: VideoCoordinatorEvent) {
        switch type {
        case .back:
            navigationController?.popToRootViewController(animated: true)
            cildren.removeLast()
        }
    }
}

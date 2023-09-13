//
//  ListCoordinator.swift
//  EfDropBoxMedia
//
//  Created by user on 13.09.2023.
//

import UIKit

enum ListCoordinatorEvent {
    case video(String?)
    case photo(String?)
    case back
}

protocol ListCoordinatorProtocol: Coordinator {
    func start()
    func eventOccurred(with type: ListCoordinatorEvent)
}

class ListCoordinator: ListCoordinatorProtocol {
    var cildren: [Coordinator] = []
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func start() {
        let vc = ListViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
}

extension ListCoordinator {
    func eventOccurred(with type: ListCoordinatorEvent) {
        switch type {
        case .video(let path):
            var detailCoordinator: VideoCoordinatorProtocol = VideoCoordinator()
            detailCoordinator.navigationController = navigationController
            cildren.append(detailCoordinator)
            detailCoordinator.start(path: path)
            detailCoordinator.handlerBack = { [unowned self] in
                self.eventOccurred(with: .back)
            }
        case .photo(let path):
            var detailCoordinator: PhotoCoordinatorProtocol = PhotoCoordinator()
            detailCoordinator.navigationController = navigationController
            cildren.append(detailCoordinator)
            detailCoordinator.start(path: path)
            detailCoordinator.handlerBack = { [unowned self] in
                self.eventOccurred(with: .back)
            }
        case .back:
            navigationController?.popToRootViewController(animated: true)
            cildren.removeLast()
        }
    }
}

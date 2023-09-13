//
//  StartCoordinator.swift
//  EfDropBoxMedia
//
//  Created by user on 13.09.2023.
//

import UIKit

protocol StartCoordinatorProtocol: Coordinator {
    func start()
}


class StartCoordinator: StartCoordinatorProtocol {
    var cildren: [Coordinator] = []
    
    var navigationController: UINavigationController?
    
    func start() {
        let vc = LoginViewController()
    //    vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
}

//
//  ImageCoordinator.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 30/01/23.
//

import UIKit

class ImageCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController
    
    var object: GalleryObject?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = UIViewController()
        controller.view.backgroundColor = .systemRed
        navigationController.pushViewController(controller, animated: true)
    }
    
}

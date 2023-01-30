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
        navigationController.navigationBar.prefersLargeTitles = false
    }
    
    func start() {
        let controller = ImageViewController()
        controller.object = object
        navigationController.pushViewController(controller, animated: true)
    }
    
}

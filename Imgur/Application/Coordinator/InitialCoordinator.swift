//
//  InitialCoordinator.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import UIKit

class InitialCoordinator: Coordinator {
    
    // MARK: - Variables
    var childCoordinator: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController
    
    // MARK: - Life Cycle
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationBar()
        setupParentCoordinator()
    }
    
    // MARK: - Setup Functions
    func setupNavigationBar() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.isTranslucent = true
    }
    
    func setupParentCoordinator() {
        parentCoordinator = self
    }
    
    // MARK: - Navigation Functions
    func start() {
        let galleryCoordinator = GalleryCoordinator(
                    navigationController: navigationController)
        
        parentCoordinator?.addChildCoordinator(galleryCoordinator)
        
        galleryCoordinator.parentCoordinator = parentCoordinator
        galleryCoordinator.start()
    }

}

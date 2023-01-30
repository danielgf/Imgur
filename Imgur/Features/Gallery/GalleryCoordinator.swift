//
//  GalleryCoordinator.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import UIKit

class GalleryCoordinator: Coordinator {
    
    // MARK: - Variables
    var childCoordinator: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController
    
    // MARK: - Life Cycle
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Navigation Functions
    func start() {
        let gallery = GalleryCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController.pushViewController(gallery, animated: true)
    }
}

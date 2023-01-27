//
//  Coordinator.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import UIKit

protocol Coordinator: AnyObject {
    
    /// This variable will keep your children coordinators
    var childCoordinator: [Coordinator] { get set }
    
    /// The parent coordinator that started this flow
    /// Every coordinator has a parent except the main coordinator
    var parentCoordinator: Coordinator? { get set }
    
    /// The navigation controller responsible to handle this flow
    var navigationController: UINavigationController { get set }
    
    /// Initialize and returns a new coordinator
    ///
    /// - Parameter navigationController: the navigation controller that handles the flow
    init(navigationController: UINavigationController)
     
    /// This function is used to start the flow
    func start()
    
}

extension Coordinator {
    
    /// Comunicates the parent coordinator that needs to add this child coordinator into the child array
    /// - Parameter coordinator: The child to be apend
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinator.append(coordinator)
    }
    
    /// Comunicates the parent coordinator that the flow managed by `him` finished and can be deallocated
    /// - Parameter coordinator: The child to be removed
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinator.enumerated() {
            if coordinator === child {
                childCoordinator.remove(at: index)
                break
            }
        }
    }
    
    /// Comunicates the parent coordinator that all the flow managed by `him` can be deallocated
    func removeAllChildCoordinators() {
        childCoordinator.removeAll()
    }
}

//
//  AppCoordinator.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 03.03.2023.
//

import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    func initialRootController()
    func showDetailScreen(_ detailViewModel: DetailViewModelProtocol)
}

class AppCoordinator: AppCoordinatorProtocol {
    
    let navigationController: UINavigationController
    let builderService: BuilderServiceProtocol
    
    init(_ builderService: BuilderServiceProtocol, _ navigationController: UINavigationController) {
        self.builderService = builderService
        self.navigationController = navigationController
    }
    
    func initialRootController() {
        navigationController.viewControllers = [
            builderService.makeLaunchScreen(coordinator: self)
        ]
    }
    
    func showDetailScreen(_ detailViewModel: DetailViewModelProtocol) {
        let vc = builderService.makeDetailScreen(detailViewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}

//
//  AppCoordinator.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 03.03.2023.
//

import UIKit

protocol AppRoutingLogic: AnyObject {
    func initialRootController()
    func showLaunchDetailsViewController(detailViewModel: DetailViewModel)
}

class AppCoordinator: AppRoutingLogic {
    
    let navigationController: UINavigationController
    let builderService: BuilderServiceProtocol
    
    init(builderService: BuilderServiceProtocol, navigationController: UINavigationController) {
        self.builderService = builderService
        self.navigationController = navigationController
    }
    
    func initialRootController() {
        navigationController.viewControllers = [
            builderService.makeLaunchsListViewController(coordinator: self)
        ]
    }
    
    func showLaunchDetailsViewController(detailViewModel: DetailViewModel) {
        let vc = builderService.makeLaunchDetailsViewController(detailViewModel: detailViewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}

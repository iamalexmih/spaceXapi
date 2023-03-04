//
//  BuilderService.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 03.03.2023.
//

import UIKit

protocol BuilderServiceProtocol: AnyObject {
    func makeLaunchsListViewController(coordinator: AppRoutingLogic) -> UIViewController
    func makeLaunchDetailsViewController(detailViewModel: DetailViewModel) -> UIViewController
}

class BuilderService: BuilderServiceProtocol {
    
    private let networkService = NetworkService()
    
    func makeLaunchsListViewController(coordinator: AppRoutingLogic) -> UIViewController {
        let vc = LaunchViewController()
        let launchViewModel = LaunchViewModel(networkService: networkService)
        vc.coordinator = coordinator
        vc.viewModel = launchViewModel
        return vc
    }

    func makeLaunchDetailsViewController(detailViewModel: DetailViewModel) -> UIViewController {
        let vc = DetailViewController()
        detailViewModel.networkService = self.networkService
        vc.viewModel = detailViewModel
        return vc
    }
}



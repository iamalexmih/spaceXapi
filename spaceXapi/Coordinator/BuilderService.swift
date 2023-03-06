//
//  BuilderService.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 03.03.2023.
//

import UIKit

protocol BuilderServiceProtocol: AnyObject {
    func makeLaunchScreen(coordinator: AppCoordinatorProtocol) -> UIViewController
    func makeDetailScreen(_ detailViewModel: DetailViewModelProtocol) -> UIViewController
}

class BuilderService: BuilderServiceProtocol {
    
    private let networkService = NetworkService()
    
    func makeLaunchScreen(coordinator: AppCoordinatorProtocol) -> UIViewController {
        let vc = LaunchViewController()
        let launchViewModel = LaunchViewModel(networkService: networkService)
        vc.coordinator = coordinator
        vc.viewModel = launchViewModel
        return vc
    }

    func makeDetailScreen(_ detailViewModel: DetailViewModelProtocol) -> UIViewController {
        let vc = DetailViewController()
        vc.viewModel = detailViewModel
        return vc
    }
}



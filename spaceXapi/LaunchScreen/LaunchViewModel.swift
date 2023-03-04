//
//  LaunchViewModel.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 03.03.2023.
//

import Foundation


class LaunchViewModel {
    var listLaunches: [Launch] = []
    var totalPages: Int = 1
    var currentPages: Int = 1
    private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchLaunchsData(_ page: Int, completion: @escaping () -> Void) {
        //TODO: Добавить Активити индикатор пока грузятся данные
        networkService.getListLaunchs(page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let listLaunches):
                self.listLaunches.append(contentsOf: listLaunches.docs) 
                self.totalPages = listLaunches.totalPages
                completion()
            case .failure(_):
                print("Error getListLaunchs")
            }
        }
    }
}

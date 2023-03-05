//
//  DetailViewModel.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 03.03.2023.
//

import Foundation



class DetailViewModel {
    var launch: Launch
    var networkService: NetworkServiceProtocol!
    var listMembersCrew: [CrewModel] = []
    
    init(launch: Launch) {
        self.launch = launch
    }
    
    func fetchCrew(completion: @escaping () -> Void) {
        if !launch.crew.isEmpty {
            guard let idLaunch = launch.id else { return }
            networkService.getListMembersCrew(idLaunch) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let listMembersCrew):
                    self.listMembersCrew = listMembersCrew.docs
                    completion()
                case .failure(_):
                    print("Error fetchCrew")
                }
            }
        }
    }
}

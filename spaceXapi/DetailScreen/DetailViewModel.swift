//
//  DetailViewModel.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 03.03.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var launch: Launch { get }
    var networkService: NetworkServiceProtocol { get set }
    var listMembersCrew: [CrewModel] { get }
    var eventHandler: ((_ event: Event) -> Void)? { get set }
    
    init(launch: Launch, networkService: NetworkServiceProtocol)
    func fetchCrew()
}

class DetailViewModel: DetailViewModelProtocol {
    var launch: Launch
    var networkService: NetworkServiceProtocol
    var listMembersCrew: [CrewModel] = []
    var eventHandler: ((Event) -> Void)?
    
    
    required init(launch: Launch, networkService: NetworkServiceProtocol) {
        self.launch = launch
        self.networkService = networkService
    }
    
    func fetchCrew() {
        if !launch.crew.isEmpty {
            guard let idLaunch = launch.id else { return }
            eventHandler?(.startLoading)
            networkService.getListMembersCrew(idLaunch) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let listMembersCrew):
                    self.listMembersCrew = listMembersCrew.docs
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
        }
    }
}

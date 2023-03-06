//
//  LaunchViewModel.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 03.03.2023.
//

import Foundation


protocol LaunchViewModelProtocol {
    var listLaunches: [Launch] { get }
    var totalPages: Int { get }
    var currentPages: Int { get set }
    var networkService: NetworkServiceProtocol  { get }
    var eventHandler: ((_ event: Event) -> Void)? { get set }
    
    init(networkService: NetworkServiceProtocol)
    func fetchLaunchsData(_ page: Int)
    func pagePlusOne()
    func isLoadMoreData(_ indexPath: IndexPath) -> Bool
}

class LaunchViewModel: LaunchViewModelProtocol {
    var listLaunches: [Launch] = []
    var totalPages: Int = 1
    var currentPages: Int = 1
    var networkService: NetworkServiceProtocol
    var eventHandler: ((_ event: Event) -> Void)?
    
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchLaunchsData(_ page: Int) {
        eventHandler?(.startLoading)
        networkService.getListLaunchs(page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let listLaunches):
                self.listLaunches.append(contentsOf: listLaunches.docs)
                self.totalPages = listLaunches.totalPages
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func pagePlusOne() {
        currentPages = currentPages + 1
    }
    
    func isLoadMoreData(_ indexPath: IndexPath) -> Bool {
        currentPages <= totalPages && indexPath.row == listLaunches.count - 1
    }
}



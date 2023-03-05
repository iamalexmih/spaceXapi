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
    var showErrorDelegate: ShowErrorDelegateProtocol? { get set }
    init(networkService: NetworkServiceProtocol)
    func fetchLaunchsData(_ page: Int, completion: @escaping () -> Void)
    func pagePlusOne()
    func isLoadMoreData(_ indexPath: IndexPath) -> Bool
}

class LaunchViewModel: LaunchViewModelProtocol {
    var listLaunches: [Launch] = []
    var totalPages: Int = 1
    var currentPages: Int = 1
    private var networkService: NetworkServiceProtocol
    var showErrorDelegate: ShowErrorDelegateProtocol?
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchLaunchsData(_ page: Int, completion: @escaping () -> Void) {
        networkService.getListLaunchs(page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let listLaunches):
                self.listLaunches.append(contentsOf: listLaunches.docs)
                self.totalPages = listLaunches.totalPages
                completion()
            case .failure(let error):
                self.showErrorDelegate?.showError(error)
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

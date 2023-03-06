//
//  ViewController.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 28.02.2023.
//

import UIKit
import Stevia




class LaunchViewController: ParentViewController {
    
    var coordinator: AppCoordinatorProtocol!
    var viewModel: LaunchViewModelProtocol!
    private let tableView = UITableView()
    private let activityLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Const.String.titleLaunchesScreen
        layoutTableView()
        configureTableView()
        observeEvent()
        loadLaunchsData(page: 1)
    }
    
    
    private func loadLaunchsData(page: Int) {
        viewModel.fetchLaunchsData(page)
    }
    
    private func observeEvent() {
        self.viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .startLoading:
                self.startLoadingIndicator()
            case .dataLoaded:
                self.stopLoadingIndicator()
                self.tableView.reloadData()
            case .error(let error):
                self.showErrorAlert(error ?? .unknownError)
            }
        }
    }
    
    override func restart(action: UIAlertAction) {
        loadLaunchsData(page: viewModel.currentPages)
    }
}

// MARK: - Configure Table View
extension LaunchViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func layoutTableView() {
        view.subviews {
            tableView
        }
        tableView.fillContainer()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: LaunchTableViewCell.cellId)
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listLaunches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.cellId, for: indexPath) as! LaunchTableViewCell
        let descriptionLaunch = viewModel.listLaunches[indexPath.row]
        cell.setupCell(descriptionLaunch)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ditalLaunch = viewModel.listLaunches[indexPath.row]
        let detailViewModel = DetailViewModel(launch: ditalLaunch, networkService: viewModel.networkService)
        coordinator.showDetailScreen(detailViewModel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isLoadMoreData(indexPath) {
            viewModel.pagePlusOne()
            loadLaunchsData(page: viewModel.currentPages)
        }
    }
}

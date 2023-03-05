//
//  ViewController.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 28.02.2023.
//

import UIKit
import Stevia


protocol ShowErrorDelegateProtocol {
    func showError(_ error: Error)
}

class LaunchViewController: UIViewController {
    
    var coordinator: AppCoordinatorProtocol!
    var viewModel: LaunchViewModelProtocol!
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Const.String.titleLaunchesScreen
        layoutTableView()
        configureTableView()
        setDelegateShowError()
        loadLaunchsData(page: 1)
    }
    
    
    private func loadLaunchsData(page: Int) {
        viewModel.fetchLaunchsData(page) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: Configure Table View
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
        let detailViewModel = DetailViewModel(launch: ditalLaunch)
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

// MARK: Show Error failure fetch LaunchsData

extension LaunchViewController: ShowErrorDelegateProtocol {
    
    func setDelegateShowError() {
        viewModel.showErrorDelegate = self
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let message = "\(error.localizedDescription) \(Const.String.Alert.restart)"
            let action = UIAlertAction(title: Const.String.Alert.actionTitle,
                                       style: .default,
                                       handler: (self.restart))
            let alertLogOut = UIAlertController(title: Const.String.Alert.messageTitle,
                                                message: message,
                                                preferredStyle: .alert)
            alertLogOut.addAction(action)
            self.present(alertLogOut, animated: true)
            print(error)
        }
    }
    
    func restart(action: UIAlertAction) {
        loadLaunchsData(page: viewModel.currentPages)
    }
}

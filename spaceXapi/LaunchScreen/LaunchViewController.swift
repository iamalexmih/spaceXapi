//
//  ViewController.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 28.02.2023.
//

import UIKit
import Stevia

class LaunchViewController: UIViewController {
    
    var coordinator: AppRoutingLogic!
    var viewModel: LaunchViewModel!
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LAUNCHES"
        layoutTableView()
        configureTableView()
        loadLaunchsData(page: 1)
    }
    
    
    private func loadLaunchsData(page: Int) {
        //TODO: Добавить Активити индикатор пока грузятся данные
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
        cell.setupCell(descriptionLaunch: descriptionLaunch)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewModel = DetailViewModel(launch: viewModel.listLaunches[indexPath.row])
        coordinator.showLaunchDetailsViewController(detailViewModel: detailViewModel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.currentPages <= viewModel.totalPages && indexPath.row == viewModel.listLaunches.count - 1 {
//TODO: Сделать чтоб ячейка переиспользовалась с нужной картинкой
            viewModel.currentPages = viewModel.currentPages + 1
            loadLaunchsData(page: viewModel.currentPages)
        }
    }
    
}

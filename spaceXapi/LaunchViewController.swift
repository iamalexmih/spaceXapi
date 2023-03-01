//
//  ViewController.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 28.02.2023.
//

import UIKit
import Stevia
import Moya

class LaunchViewController: UIViewController {

    var launches: [LaunchModel] = []
    
    let tableView = UITableView()
//    let logoView = UIImageView()

    let titleLabel = UILabel()



    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //        loadData()
        title = "LAUNCHES"
        
        layoutTableView()
        configureTableView()
    }

    
    func loadData(isFirstLoad: Bool = false) {
//        if isFirstLoad {
//            launches = []
//            tableView.reloadData()
//            activityIndicator.startAnimating()
//        }


        let completion = {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()

            if self.launches.count > 0 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }

        let provider = MoyaProvider<ApiService>()
        
        provider.request(.pastLaunches(page: 10))
        { result in

            switch result {
                
            case .success(let response):
                do {
                    let launchData = try response.map(LaunchModel.self)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print("Error Moya", error.localizedDescription)
            }

//            completion()
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
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.cellId, for: indexPath) as! LaunchTableViewCell
       
        
        return cell
    }
}

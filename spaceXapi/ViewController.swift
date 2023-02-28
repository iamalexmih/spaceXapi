//
//  ViewController.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 28.02.2023.
//

import UIKit
import Stevia
import Moya

class ViewController: UIViewController {

    var launches: [LaunchModel] = []

    let logoView = UIImageView()

    let titleLabel = UILabel()

    let tableView = UITableView()


    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
        
    }

    
    func loadData(isFirstLoad: Bool = false)
    {
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
        
        provider.request(.pastLaunches)
        { result in

            switch result {
                
            case .success(let response):
                print(response.request?.url)
                do {
                    let launchData = try response.map([LaunchModel].self)
                    print(launchData)
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


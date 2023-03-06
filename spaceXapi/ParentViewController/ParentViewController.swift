//
//  ViewController.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 06.03.2023.
//

import UIKit


class ParentViewController: UIViewController {
    private let activityLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewsAndLabels()
        addNavigationItem()
    }
    
    
    func startLoadingIndicator() {
        activityLabel.isHidden = false
        activityIndicator.startAnimating()
    }
    
    
    func stopLoadingIndicator() {
        activityLabel.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    
    private func addNavigationItem() {
        let barButtonActivIndicator = UIBarButtonItem(customView: activityIndicator)
        let barButtonActivLabel = UIBarButtonItem(customView: activityLabel)
        navigationItem.setRightBarButtonItems([barButtonActivIndicator, barButtonActivLabel], animated: true)
    }
    
    
    private func configureViewsAndLabels() {
        activityIndicator.color = Const.Color.darkGray
        activityLabel.isHidden = true
        activityLabel.text = Const.String.loadingProcess
        activityLabel.font = UIFont.systemFont(ofSize: 10)
        activityLabel.textColor = Const.Color.darkGray
    }
    
    
    func showErrorAlert(_ error: NetworkError) {
        let message = "\(error.localizedDescription). \(Const.String.Alert.restart)"
        let action = UIAlertAction(title: Const.String.Alert.actionTitle,
                                   style: .default,
                                   handler: (restart))
        let alertLogOut = UIAlertController(title: Const.String.Alert.messageTitle,
                                            message: message,
                                            preferredStyle: .alert)
        alertLogOut.addAction(action)
        present(alertLogOut, animated: true)
        print(error)
    }
    
    @objc func restart(action: UIAlertAction) { }
}

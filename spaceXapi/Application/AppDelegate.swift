//
//  AppDelegate.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 28.02.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Properties
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        window = UIWindow(frame: UIScreen.main.bounds)
        let builderService = BuilderService()
        let navigationController = UINavigationController()
        let coordinator = AppCoordinator(builderService, navigationController)
        coordinator.initialRootController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}


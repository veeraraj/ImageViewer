//
//  AppDelegate.swift
//  ImageViewer
//
//  Created by Veera on 11/10/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //--------------------------------------------------------------------------
    // MARK: - cooridnator Properties
    //--------------------------------------------------------------------------

    var coordinator: MainCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //--------------------------------------------------------------------------
        // MARK: - Setting up cooridnator
        //--------------------------------------------------------------------------

        let navigationController = UINavigationController()
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.barTintColor = .lightGray
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.isTranslucent = false

        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}


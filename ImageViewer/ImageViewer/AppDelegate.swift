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

        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = MainCoordinator(window: window!)
        coordinator?.start()

        return true
    }
}


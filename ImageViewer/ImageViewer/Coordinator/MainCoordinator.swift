//
//  MainCoordinator.swift
//  ImageViewer
//
//  Created by Veera on 11/10/20.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {

    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------

    var childCoordinator = [Coordinator]()
    var navigationController: UINavigationController?
    let window : UIWindow

    //--------------------------------------------------------------------------
    // MARK: - Init
    //--------------------------------------------------------------------------

    init(window: UIWindow) {
        self.window = window
    }

    //--------------------------------------------------------------------------
    // MARK: - Navigation methods
    //--------------------------------------------------------------------------

    func start() {
        let navigationController = UINavigationController(rootViewController: ImageViewController())
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.barTintColor = .lightGray
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.isTranslucent = false
        self.navigationController = navigationController

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

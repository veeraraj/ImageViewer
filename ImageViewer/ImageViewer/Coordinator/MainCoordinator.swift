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
    var navigationController: UINavigationController

    //--------------------------------------------------------------------------
    // MARK: - Init
    //--------------------------------------------------------------------------

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    //--------------------------------------------------------------------------
    // MARK: - Navigation methods
    //--------------------------------------------------------------------------

    func start() {
        let vc = ViewController()
        vc.view.frame = UIScreen.main.bounds
        vc.view.backgroundColor = .yellow
        vc.coorodinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

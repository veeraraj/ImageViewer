//
//  Coordinator.swift
//  ImageViewer
//
//  Created by Veera on 11/10/20.
//

import Foundation
import UIKit

protocol Coordinator {

    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------

    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    //--------------------------------------------------------------------------
    // MARK: - Methods
    //--------------------------------------------------------------------------

    func start()
}

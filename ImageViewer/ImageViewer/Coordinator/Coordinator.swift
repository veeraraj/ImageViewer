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

    //--------------------------------------------------------------------------
    // MARK: - Methods
    //--------------------------------------------------------------------------

    func start()
}

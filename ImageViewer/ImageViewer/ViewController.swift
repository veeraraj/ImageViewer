//
//  ViewController.swift
//  ImageViewer
//
//  Created by Veera on 11/10/20.
//

import UIKit

class ImageViewController: MainViewController {
    
    weak var coorodinator: MainCoordinator? //Coordinator that handles navigation

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.showLoader()
    }
}


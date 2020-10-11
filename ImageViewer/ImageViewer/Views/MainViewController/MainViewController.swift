//
//  MainViewController.swift
//  ImageViewer
//
//  Created by Veera on 12/10/20.
//

import UIKit

fileprivate struct Constants {
    static let networkIndicatorViewFrame: CGRect = CGRect(x: 0.0, y: UIScreen.bottomPosition,
                                                          width: UIScreen.width, height: 44.0)
    static let alertTitle = "Image Loader App"
    static let alertOk = "Ok"
}

class MainViewController: UIViewController, ReachabilityObesrver {

    //--------------------------------------------------------------------------
    // MARK: -  Properties
    //--------------------------------------------------------------------------

    let networkIndicatorView = NetworkIndicatorView(frame: Constants.networkIndicatorViewFrame)

    //--------------------------------------------------------------------------
    // MARK: -  View lifecylle
    //--------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()

        try? addReachabilityObservers()
        UIApplication.shared.keyWindow?.addSubview(networkIndicatorView)
    }

    //--------------------------------------------------------------------------
    // MARK: -  Reachability Methods
    //--------------------------------------------------------------------------

    func isConnectionAvailabe(_ isReachable: Bool) {
        self.networkIndicatorView.isHidden = isReachable == true
    }

    func isConnectionAvailable() -> Bool {
        return isNetworkAvailable()
    }

    func removeRechabilityObservers() {
        removeReachabilityObservers()
    }
}

extension MainViewController {

    //--------------------------------------------------------------------------
    // MARK: -  Alert Method
    //--------------------------------------------------------------------------

    func showAlert(with message: String) {
        ThreadHelper.mainThreadAsync {
            let alertController = UIAlertController(title: Constants.alertTitle, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: Constants.alertOk, style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension MainViewController {

    //--------------------------------------------------------------------------
    // MARK: -  Loader
    //--------------------------------------------------------------------------

    func showLoader() {
        ThreadHelper.mainThreadAsync {
            LoadingView.shared.showLoader()
        }
    }

    func hideLoader() {
        ThreadHelper.mainThreadAsync {
            LoadingView.shared.hideLoader()
        }
    }
}

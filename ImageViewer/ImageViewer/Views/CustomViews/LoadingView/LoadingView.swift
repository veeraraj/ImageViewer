//
//  LoadingView.swift
//  ImageViewer
//
//  Created by Veera on 12/10/20.
//

import Foundation
import UIKit

class LoadingView {

    //--------------------------------------------------------------------------
    // MARK: - Shared Instance
    //--------------------------------------------------------------------------

    static let shared = LoadingView()

    //--------------------------------------------------------------------------
    // MARK: - Public properties
    //--------------------------------------------------------------------------

    public var isLoading: Bool {
        return loadingIndcitaor.isAnimating
    }

    //--------------------------------------------------------------------------
    // MARK: - Private properties
    //--------------------------------------------------------------------------

    private var blurView = UIImageView()
    private var loadingIndcitaor = UIActivityIndicatorView()

    //--------------------------------------------------------------------------
    // MARK: - Init
    //--------------------------------------------------------------------------

    private init() {
        blurView.frame = UIScreen.main.bounds
        blurView.alpha = 0.5
        loadingIndcitaor.center = blurView.center
    }

    //--------------------------------------------------------------------------
    // MARK: - Public methods
    //--------------------------------------------------------------------------

    public func showLoader(with bluredViewColor: UIColor? = nil,
                           loaderStyle: UIActivityIndicatorView.Style? = nil) {
        guard self.isLoading == false else {
            return
        }

        blurView.backgroundColor = bluredViewColor ?? .gray
        loadingIndcitaor.style = loaderStyle ?? .whiteLarge

        self.loadingIndcitaor.startAnimating()

        UIApplication.shared.keyWindow?.addSubview(self.blurView)
        UIApplication.shared.keyWindow?.addSubview(self.loadingIndcitaor)
    }

    public func hideLoader() {
        guard self.isLoading else {
            return
        }

        self.loadingIndcitaor.stopAnimating()
        self.blurView.removeFromSuperview()
        self.loadingIndcitaor.removeFromSuperview()
    }
}

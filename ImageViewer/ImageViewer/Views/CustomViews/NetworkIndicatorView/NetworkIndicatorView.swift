//
//  NetworkIndicatorView.swift
//  ImageViewer
//
//  Created by Veera on 12/10/20.
//

import Foundation
import UIKit

class NetworkIndicatorView: UIView {

    //--------------------------------------------------------------------------
    // MARK: - private Properties
    //--------------------------------------------------------------------------

    private var stactView: UIStackView = UIStackView()
    private var label: UILabel = UILabel()

    //--------------------------------------------------------------------------
    // MARK: - init
    //--------------------------------------------------------------------------

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //--------------------------------------------------------------------------
    // MARK: - private methods
    //--------------------------------------------------------------------------

    private func configureView() {
        self.backgroundColor = .red

        self.stactView.frame = CGRect(origin: .zero, size: self.frame.size)
        self.stactView.axis = .horizontal

        self.label.frame = self.stactView.frame
        self.label.backgroundColor = .red
        self.label.textAlignment = .center
        self.label.textColor = .white
        self.label.font = UIFont.boldSystemFont(ofSize: 14.0)
        self.label.text = StringConstants.noConnectivity.localizedString()

        self.stactView.addArrangedSubview(label)
        self.addSubview(self.stactView)
    }
}

//
//  UIScreen+Extensions.swift
//  ImageViewer
//
//  Created by Veera on 12/10/20.
//

import Foundation
import UIKit

extension UIScreen {
    
    //--------------------------------------------------------------------------
    // MARK: - Custom Properties
    //--------------------------------------------------------------------------

    class var bottomPosition: CGFloat {
        self.main.bounds.maxY - 44.0
    }

    class var width: CGFloat {
        self.main.bounds.width
    }

    class var height: CGFloat {
        self.main.bounds.height
    }
}

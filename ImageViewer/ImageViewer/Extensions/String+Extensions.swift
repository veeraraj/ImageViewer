//
//  String+Extensions.swift
//  ImageViewer
//
//  Created by Veera on 12/10/20.
//

import Foundation

extension String {
    
    //--------------------------------------------------------------------------
    // MARK: - Custom Properties
    //--------------------------------------------------------------------------

    func localizedString(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}

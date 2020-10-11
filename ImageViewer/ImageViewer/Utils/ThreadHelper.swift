//
//  ThreadHelper.swift
//  ImageViewer
//
//  Created by Veera on 11/10/20.
//

import Foundation
import UIKit

public class ThreadHelper {

    //--------------------------------------------------------------------------
    // MARK: - Methods
    //--------------------------------------------------------------------------

    class func mainThread(_ closure: () -> Void) {
        if Thread.current == Thread.main {
            closure()
        } else {
            DispatchQueue.main.sync(execute: closure)
        }
    }

    class func mainThreadAsync(_ closure: @escaping () -> Void) {
        if Thread.current == Thread.main {
            closure()
        } else {
            DispatchQueue.main.async(execute: closure)
        }
    }
}

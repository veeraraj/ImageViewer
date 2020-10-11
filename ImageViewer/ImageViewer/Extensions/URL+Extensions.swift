//
//  URL+Extensions.swift
//  ImageViewer
//
//  Created by Veera on 11/10/20.
//

import Foundation

extension URL {

    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------

    func addQueryParams(params: [String: String]? = nil) -> URL {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return self.absoluteURL
        }

        urlComponents.queryItems = params?.compactMap({ (key, value) in  URLQueryItem(name: key, value: value) })

        return urlComponents.url ?? self.absoluteURL
    }
}

//
//  URLRouter.swift
//  ImageViewer
//
//  Created by Veera on 11/10/20.
//

import Foundation

enum URLRouterHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum EndPointURLs: String {
    case test,
    production = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}

struct URLRouter<T: Codable> {

    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------

    var urlString: String
    let httpMethod: URLRouterHTTPMethod
    let queryParams: [String: String]? = nil
    let headerParams: [String: Any]? = nil

    var url: URL? {
        let finalURLString = [urlString].joined(separator: "/")
        return URL(string: finalURLString)?.addQueryParams(params: queryParams)
    }
}

//
//  NetworkError.swift
//  ImageViewer
//
//  Created by Veera on 11/10/20.
//

import Foundation

enum NetworkError: Error {
    case noResponse
    case badURL
    case badServerResponse
    case decodingFailed
    case noInternetConnection
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noResponse:
            return StringConstants.networkErrorNoResponse.localizedString()
        case .badURL:
            return StringConstants.networkErrorBadURL.localizedString()
        case .badServerResponse:
            return StringConstants.networkErrorBadServerResponse.localizedString()
        case .decodingFailed:
            return StringConstants.networkErrorDecodingFailed.localizedString()
        case .noInternetConnection:
            return StringConstants.networkErrorNoInternet.localizedString()
        }
    }
}

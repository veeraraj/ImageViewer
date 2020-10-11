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
            return NSLocalizedString("No response from the server.", comment: "noResponse")
        case .badURL:
            return NSLocalizedString("Please check the URL.", comment: "badURL")
        case .badServerResponse:
            return NSLocalizedString("Invalid response from the server.", comment: "badServerResponse")
        case .decodingFailed:
            return NSLocalizedString("Unable to decode the received json. Please check your parser", comment: "decodingFailed")
        case .noInternetConnection:
            return NSLocalizedString("Internet connectivity seems to be unavailabe. Please check.", comment: "noInternetConnection")
        }
    }
}

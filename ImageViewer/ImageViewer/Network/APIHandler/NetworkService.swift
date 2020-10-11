//
//  NetworkService.swift
//  ImageViewer
//
//  Created by Veera on 11/10/20.
//

import Foundation

class NetworkService {

    //--------------------------------------------------------------------------
    // MARK: - Shared Instance
    //--------------------------------------------------------------------------

    static let shared = NetworkService()

    //--------------------------------------------------------------------------
    // MARK: - Methods
    //--------------------------------------------------------------------------

    func load<T>(router: URLRouter<T>, completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = router.url else {
            completion(.failure(NetworkError.badURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.httpMethod.rawValue

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in

            if let error = self.validateError(from: response, data: data, error: error) {
                completion(.failure(error))
                return
            }

            do {
                guard
                    let data = data
                    else {
                        ThreadHelper.mainThreadAsync {
                            completion(.failure(NetworkError.noResponse))
                        }
                        return
                }
             
                /* To fix the error Unable to convert data to string around character 2643 have to convert the response data to utfd data*/
                guard
                    let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8),
                    let result = try? JSONDecoder().decode(T.self, from: utf8Data)
                else {
                    ThreadHelper.mainThreadAsync {
                        completion(.failure(NetworkError.decodingFailed))
                    }
                    return
                }
                ThreadHelper.mainThreadAsync {
                    completion(.success(result))
                }
            }
        }

        dataTask.resume()
    }

    //--------------------------------------------------------------------------
    // MARK: - Private Methods
    //--------------------------------------------------------------------------

    private func validateError(from response: URLResponse?,
                               data: Data?,
                               error: Error?) -> Error? {

        if let error = error {
            return error
        }

        guard
            let response = response as? HTTPURLResponse,
            data != nil
        else {
                return NetworkError.noResponse
        }

        switch response.statusCode {
        case 200...300:
            return nil
        default:
            return NetworkError.badServerResponse
        }
    }
}

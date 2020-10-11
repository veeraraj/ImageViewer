//
//  FactListViewModel.swift
//  ImageViewer
//
//  Created by Veera on 12/10/20.
//

import Foundation

class FactListViewModel {

    //--------------------------------------------------------------------------
    // MARK: - Init
    //--------------------------------------------------------------------------

    init() { }
    
    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------

    var imageData: ImageModel?
    
    var facts: [Row] {
        return imageData?.rows ?? []
    }
    
    var factTitle: String {
        return imageData?.title ?? ""
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Methods
    //--------------------------------------------------------------------------

    func getImages(completion: @escaping (_ error: Error?) -> Void) {
        let urlRouter = URLRouter<ImageModel>(urlString: EndPointURLs.production.rawValue, httpMethod: .get)
        
        NetworkService.shared.load(router: urlRouter) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageData = imageData
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}

//
//  ImageViewerTests.swift
//  ImageViewerTests
//
//  Created by Veera on 11/10/20.
//

import XCTest
@testable import ImageViewer

class ImageViewerTests: XCTestCase {
    var mockNetworkService: MockNetworkService?
    var imageListViewModel: FactListViewModel?

    override func setUpWithError() throws {
        mockNetworkService = MockNetworkService()
        imageListViewModel = FactListViewModel()
    }

    override func tearDownWithError() throws {
        mockNetworkService = nil
    }

    func test_Network_BadURL_Error() {
        let urlRouter = URLRouter<ImageModel>(urlString: "", httpMethod: .get)
        var errorMessage: Error?
        
        mockNetworkService?.load(router: urlRouter) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                errorMessage = error
            }
        }
        
        XCTAssertEqual(errorMessage?.localizedDescription, NetworkError.badURL.errorDescription)
    }
    
    func test_Network_Mock_Data() {
        guard let mockFilePath = self.getMockFilePath() else {
            fatalError("UnitTestData.json not found")
        }
        let urlRouter = URLRouter<ImageModel>(urlString: mockFilePath, httpMethod: .get)
        
        var mockResult: ImageModel?
        mockNetworkService?.load(router: urlRouter) { result in
            switch result {
            case .success(let result):
                mockResult = result
            case .failure(_):
                break
            }
        }
        
        XCTAssertEqual(mockResult?.title, "About Canada")
        XCTAssertEqual(mockResult?.rows.count, 13)
    }
    
    func test_ViewModel_Empty_Title() {
        XCTAssertEqual(imageListViewModel?.factTitle, "")
    }
    
    func test_ViewModel_Empty_Rows() {
        XCTAssertEqual(imageListViewModel?.facts.count, 0)
    }

    func test_ViewModel_Empty_ImageData() {
        XCTAssertNil(imageListViewModel?.imageData)
    }
    
    func test_ViewModel_With_FactData() {
        guard let mockFilePath = self.getMockFilePath() else {
            fatalError("UnitTestData.json not found")
        }
        let urlRouter = URLRouter<ImageModel>(urlString: mockFilePath, httpMethod: .get)
        
        var mockResult: ImageModel?
        mockNetworkService?.load(router: urlRouter) { result in
            switch result {
            case .success(let result):
                mockResult = result
            case .failure(_):
                break
            }
        }
        
        imageListViewModel?.imageData = mockResult
        
        XCTAssertEqual(imageListViewModel?.factTitle, "About Canada")
        XCTAssertEqual(imageListViewModel?.facts.count, 13)
        XCTAssertNotNil(imageListViewModel?.imageData)
    }
    
    private func getMockFilePath() -> String? {
        guard
            let pathString = Bundle(for: type(of: self)).path(forResource: "ImageMock", ofType: "json")
        else {
            return nil
        }
        
        return pathString
    }
}

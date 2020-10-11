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

    override func setUpWithError() throws {
        mockNetworkService = MockNetworkService()
    }

    override func tearDownWithError() throws {
        mockNetworkService = nil
    }

    func test_Network_BadURL_Error() throws {
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
    
    func test_Network_Mock_Data() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "ImageMock", ofType: "json") else {
            fatalError("UnitTestData.json not found")
        }
        
        let urlRouter = URLRouter<ImageModel>(urlString: pathString, httpMethod: .get)
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

    func testPerformanceExample() throws {
        self.measure {
            
        }
    }

}

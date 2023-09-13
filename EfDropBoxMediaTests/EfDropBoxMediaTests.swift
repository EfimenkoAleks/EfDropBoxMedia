//
//  EfDropBoxMediaTests.swift
//  EfDropBoxMediaTests
//
//  Created by user on 13.09.2023.
//

import XCTest
@testable import EfDropBoxMedia

final class EfDropBoxMediaTests: XCTestCase {
 
    private let networkService: NetWorkServiceProtocol = NetWorkService()

    func testGetList() {
        let expectation = expectation(description: "Test downloading file")
        let folder = ""
        networkService.getList(path: folder) { [weak self] result in
            switch result {
            case .success(let object):
                self?.cursor = object.cursor
                XCTAssert(object.listModels.isEmpty)
                        expectation.fulfill()
            case .failure(_):
                XCTFail([])
            }
        }
      }
    
    func testDownLoad() {
        let expectation = expectation(description: "Test downloading photo")
        let path = "/picture6.jpeg"
        networkService.downLoadPreviewPhoto(path: path) { result in
          
            XCTAssertEqual(result, .loadedVideo(PhotoModel))
            expectation.fulfill()
        }
    }
    
    func testDownLoadVideo() {
        let expectation = expectation(description: "Test downloading video")
        let path = ""
        networkService.download(path: path) { result in
        
            XCTAssertNotEqual(result, .error)
            expectation.fulfill()
        }
    }

}

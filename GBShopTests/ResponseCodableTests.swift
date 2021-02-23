//
//  ResponseCodableTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 16.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ResponseCodableTests: XCTestCase {
    
    func testShouldDownloadAndParse() {
        let errorParser = ErrorParserStub()
        let downloaded = expectation(description: "Data downloaded")
        
        AF
            .request("https://jsonplaceholder.typicode.com/posts/1")
            .responseCodable(errorParser: errorParser) { (response: DataResponse<PostStub, AFError>) in
                switch response.result {
                case .success(_):
                    downloaded.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
        }
        waitForExpectations(timeout: 10)
    }
    
}

struct PostStub: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum ApiErrorStub: Error {
    case fatalError
}

struct ErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}


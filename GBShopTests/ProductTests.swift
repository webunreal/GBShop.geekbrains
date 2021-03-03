//
//  ProductTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 16.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ProductTests: XCTestCase {
    func testProductGetting() {
        let requestFactory = RequestFactory()
        let goodData = requestFactory.makeProductRequestFactory()
        let fakeData = FakeData()
        let good = expectation(description: "Got Product")
        
        goodData.getProduct(productId: fakeData.productId) { response in
            switch response.result {
            case .success(let goodResponse):
                print(goodResponse)
                XCTAssertEqual(goodResponse.result, 1)
                good.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 10)
    }

}

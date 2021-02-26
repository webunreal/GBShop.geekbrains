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
        let productData = requestFactory.makeProductRequestFactory()
        let fakeData = FakeData()
        let product = expectation(description: "Got Product")
        
        productData.getProduct(productId: fakeData.productId) { response in
            switch response.result {
            case .success(let productResponse):
                XCTAssertEqual(productResponse.result, 1)
                product.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

//
//  AddToCartTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class AddToCartTests: XCTestCase {
    func testAddToCart() {
        let requestFactory = RequestFactory()
        let addToCartData = requestFactory.makeAddToCartRequestFactory()
        let fakeData = FakeData()
        let addToCartExpectation = expectation(description: "Product added to Cart")
        
        addToCartData.addToCart(productId: fakeData.productId, quantity: fakeData.quantity) { response in
            switch response.result {
            case .success(let addToCartResponse):
                XCTAssertEqual(addToCartResponse.result, 1)
                addToCartExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

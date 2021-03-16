//
//  AddToBasketTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class AddToBasketTests: XCTestCase {
    func testAddToBasket() {
        let requestFactory = RequestFactory()
        let addToBasketData = requestFactory.makeAddToBasketRequestFactory()
        let fakeData = FakeData()
        let addToBasketExpectation = expectation(description: "Product added to Basket")
        
        addToBasketData.addToBasket(productId: fakeData.productId, quantity: fakeData.quantity) { response in
            switch response.result {
            case .success(let addToBasketResponse):
                XCTAssertEqual(addToBasketResponse.result, 1)
                addToBasketExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

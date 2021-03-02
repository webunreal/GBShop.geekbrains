//
//  DeleteFromBasketTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class DeleteFromBasketTests: XCTestCase {
    func testDeleteFromBasket() {
        let requestFactory = RequestFactory()
        let deleteFromBasketData = requestFactory.makeDeleteFromBasketRequestFactory()
        let fakeData = FakeData()
        let deleteFromBasketExpectation = expectation(description: "Product deleted from Basket")
        
        deleteFromBasketData.deleteFromBasket(productId: fakeData.productId) { response in
            switch response.result {
            case .success(let deleteFromResponse):
                XCTAssertEqual(deleteFromResponse.result, 1)
                deleteFromBasketExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

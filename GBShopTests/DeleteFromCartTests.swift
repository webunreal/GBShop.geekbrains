//
//  DeleteFromCartTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class DeleteFromCartTests: XCTestCase {
    func testDeleteFromCart() {
        let requestFactory = RequestFactory()
        let deleteFromCartData = requestFactory.makeDeleteFromCartRequestFactory()
        let fakeData = FakeData()
        let deleteFromCartExpectation = expectation(description: "Product deleted from Cart")
        
        deleteFromCartData.deleteFromCart(productId: fakeData.productId) { response in
            switch response.result {
            case .success(let deleteFromCartResponse):
                XCTAssertEqual(deleteFromCartResponse.result, 1)
                deleteFromCartExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

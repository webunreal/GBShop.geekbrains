//
//  GetCartTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 24.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class GetBasketTests: XCTestCase {
    func testGetBasket() {
        let requestFactory = RequestFactory()
        let getCartData = requestFactory.makeGetCartRequestFactory()
        let fakeData = FakeData()
        let getCartExpectation = expectation(description: "Basked paid")
        
        getCartData.getCart(userId: fakeData.userId) { response in
            switch response.result {
            case .success(let getBasketResponse):
                XCTAssertEqual(getBasketResponse.amount, 46600)
                getCartExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

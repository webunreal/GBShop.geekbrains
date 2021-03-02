//
//  PayBasketTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class PayBasketTests: XCTestCase {
    func testPayBasket() {
        let requestFactory = RequestFactory()
        let payBasketData = requestFactory.makePayBasketRequestFactory()
        let fakeData = FakeData()
        let payBasketExpectation = expectation(description: "Basked paid")
        
        payBasketData.payBasket(userId: fakeData.userId) { response in
            switch response.result {
            case .success(let payBasketResponse):
                XCTAssertEqual(payBasketResponse.result, 1)
                payBasketExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

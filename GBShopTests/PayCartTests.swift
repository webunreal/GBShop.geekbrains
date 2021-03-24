//
//  PayBasketTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class PayCartTests: XCTestCase {
    func testPayBasket() {
        let requestFactory = RequestFactory()
        let payCartData = requestFactory.makePayCartRequestFactory()
        let fakeData = FakeData()
        let payCartExpectation = expectation(description: "Basked paid")
        
        payCartData.payCart(userId: fakeData.userId) { response in
            switch response.result {
            case .success(let payCartResponse):
                XCTAssertEqual(payCartResponse.result, 1)
                payCartExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

//
//  GoodTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 16.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class GoodTests: XCTestCase {
    func testGoodGetting() {
        let requestFactory = RequestFactory()
        let goodData = requestFactory.makeGoodRequestFactory()
        let fakeData = FakeData()
        let good = expectation(description: "Got Good")
        
        goodData.getGood(productId: fakeData.productId) { response in
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

//
//  LogOutTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 16.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class LogOutTests: XCTestCase {
    func testLogOut() {
        let requestFactory = RequestFactory()
        let logOut = requestFactory.makeLogOutRequestFactory()
        let fakeData = FakeData()
        let loggedOutExpectation = expectation(description: "Logged Out")
        
        logOut.logOut(userId: fakeData.userId) { response in
            switch response.result {
            case .success(let logOutResponse):
                XCTAssertEqual(logOutResponse.result, 1)
                loggedOutExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

//
//  LogInTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 16.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class LogInTests: XCTestCase {
    func testLogIn() {
        let requestFactory = RequestFactory()
        let logIn = requestFactory.makeLogInRequestFatory()
        let fakeData = FakeData()
        let logedIn = expectation(description: "Logged In")
        
        logIn.logIn(login: fakeData.login, password: fakeData.password) { response in
            switch response.result {
            case .success(let login):
                XCTAssertEqual(login.user.id, 123)
                logedIn.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

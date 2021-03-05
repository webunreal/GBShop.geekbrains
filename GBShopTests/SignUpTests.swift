//
//  SignUpTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 16.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class SignUpTests: XCTestCase {
    func testSignUp() {
        let requestFactory = RequestFactory()
        let signUp = requestFactory.makeSignUpRequestFactory()
        let fakeData = FakeData()
        let registered = expectation(description: "Registered")
        
        signUp.signUp(userId: fakeData.userId,
                      login: fakeData.login,
                      password: fakeData.password,
                      email: fakeData.email,
                      gender: fakeData.gender,
                      creditCard: fakeData.creditCard,
                      bio: fakeData.bio) { response in
            switch response.result {
            case .success(let registerResponse):
                XCTAssertEqual(registerResponse.result, 1)
                registered.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

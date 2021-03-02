//
//  ChangeUserDataTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 16.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ChangeUserDataTests: XCTestCase {
    func testUserDataChanging() {
        let requestFactory = RequestFactory()
        let changeUserData = requestFactory.makeChangeUserDataRequestFactory()
        let fakeData = FakeData()
        let changedExpectation = expectation(description: "Data Changed")
        
        changeUserData.changeUserData(userId: fakeData.userId,
                                      login: fakeData.login,
                                      password: fakeData.password,
                                      email: fakeData.email,
                                      gender: fakeData.gender,
                                      creditCard: fakeData.creditCard,
                                      bio: fakeData.bio) { response in
            switch response.result {
            case .success(let changeUserDataResponse):
                XCTAssertEqual(changeUserDataResponse.result, 1)
                changedExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

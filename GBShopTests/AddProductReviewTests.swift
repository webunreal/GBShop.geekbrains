//
//  AddProductReviewTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class AddProductReviewTests: XCTestCase {
    func testAddProductReview() {
        let requestFactory = RequestFactory()
        let addReviewData = requestFactory.makeAddProductReviewRequestFactory()
        let fakeData = FakeData()
        let addReview = expectation(description: "Review added")
        
        addReviewData.addReview(userId: fakeData.userId,
                                text: fakeData.reviewText) { response in
            switch response.result {
            case .success(let addReviewResponse):
                XCTAssertEqual(addReviewResponse.result, 1)
                addReview.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

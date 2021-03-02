//
//  ProductReviewsTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ProductReviewsTests: XCTestCase {
    func testProductReviews() {
        let requestFactory = RequestFactory()
        let productReviewsData = requestFactory.makeProductReviewsRequestFactory()
        let fakeData = FakeData()
        let reviewsExpectation = expectation(description: "Got Reviews")
        
        productReviewsData.getReviews(productId: fakeData.productId) { response in
            switch response.result {
            case .success(let reviewsResponse):
                XCTAssertEqual(reviewsResponse.pageNumber, 1)
                XCTAssertEqual(reviewsResponse.reviews[0].commentId, 123)
                reviewsExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

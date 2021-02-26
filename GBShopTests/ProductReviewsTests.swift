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
        let reviews = expectation(description: "Got Reviews")
        
        productReviewsData.getReviews(productId: fakeData.productId) { response in
            switch response.result {
            case .success(let reviewsResponse):
                XCTAssertEqual(reviewsResponse.pageNumber, 1)
                reviews.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

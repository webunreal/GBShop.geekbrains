//
//  DeleteProductReviewTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class DeleteProductReviewTests: XCTestCase {
    func testDeleteProductReview() {
        let requestFactory = RequestFactory()
        let deleteReviewData = requestFactory.makeDeleteProductReviewRequestFactory()
        let fakeData = FakeData()
        let deleteReviewExpectation = expectation(description: "Review approved")
        
        deleteReviewData.deleteReview(commentId: fakeData.commentId) { response in
            switch response.result {
            case .success(let deleteReviewResponse):
                XCTAssertEqual(deleteReviewResponse.result, 1)
                deleteReviewExpectation.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

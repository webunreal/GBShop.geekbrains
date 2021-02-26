//
//  ApproveProductReviewTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ApproveProductReviewTests: XCTestCase {
    func testApproveProductReview() {
        let requestFactory = RequestFactory()
        let approveReviewData = requestFactory.makeApproveProductReviewRequestFactory()
        let fakeData = FakeData()
        let approveReview = expectation(description: "Review approved")
        
        approveReviewData.approveReview(commentId: fakeData.commentId) { response in
            switch response.result {
            case .success(let approveReviewResponse):
                XCTAssertEqual(approveReviewResponse.result, 1)
                approveReview.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

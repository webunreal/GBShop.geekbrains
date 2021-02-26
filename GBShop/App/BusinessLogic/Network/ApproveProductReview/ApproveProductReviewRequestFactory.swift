//
//  ApproveProductReviewRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import Foundation
import Alamofire

protocol ApproveProductReviewRequestFactory {
    func approveReview(commentId: Int,
                       completionHandler: @escaping (AFDataResponse<ApproveProductReviewResult>) -> Void)
}

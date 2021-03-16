//
//  DeleteProductReviewRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import Foundation
import Alamofire

protocol DeleteProductReviewRequestFactory {
    func deleteReview(
        commentId: Int,
        completionHandler: @escaping (AFDataResponse<DeleteProductReviewResult>) -> Void
    )
}

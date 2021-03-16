//
//  AddProductReviewRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import Foundation
import Alamofire

protocol AddProductReviewRequestFactory {
    func addReview(
        userId: Int,
        text: String,
        completionHandler: @escaping (AFDataResponse<AddProductReviewResult>) -> Void
    )
}

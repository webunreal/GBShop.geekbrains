//
//  ProductReviewsFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import Foundation
import Alamofire

protocol ProductReviewsRequestFactory {
    func getReviews(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<ProductReviewsResult>) -> Void
    )
}

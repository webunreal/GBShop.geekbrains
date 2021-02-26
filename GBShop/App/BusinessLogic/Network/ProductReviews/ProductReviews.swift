//
//  ProductReviews.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import Foundation
import Alamofire

class ProductReviews: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue,
        baseUrl: URL) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        self.baseUrl = baseUrl
    }
}

extension ProductReviews: ProductReviewsRequestFactory {
    func getReviews(productId: Int, completionHandler: @escaping (AFDataResponse<ProductReviewsResult>) -> Void) {
        let requestModel = ProductReviews(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ProductReviews {
    struct ProductReviews: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "get_product_reviews"
        
        let productId: Int
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
}

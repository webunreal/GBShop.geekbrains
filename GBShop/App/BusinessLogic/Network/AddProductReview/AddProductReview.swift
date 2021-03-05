//
//  AddProductReview.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import Foundation
import Alamofire

class AddProductReview: AbstractRequestFactory {
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

extension AddProductReview: AddProductReviewRequestFactory {
    func addReview(userId: Int,
                   text: String,
                   completionHandler: @escaping (AFDataResponse<AddProductReviewResult>) -> Void) {
        let requestModel = AddProductReview(baseUrl: baseUrl,
                                            userId: userId,
                                            text: text)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension AddProductReview {
    struct AddProductReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "add_product_review"
        
        let userId: Int
        let text: String
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "text": text
            ]
        }
    }
}

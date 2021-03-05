//
//  DeleteProductReview.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import Foundation
import Alamofire

class DeleteProductReview: AbstractRequestFactory {
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

extension DeleteProductReview: DeleteProductReviewRequestFactory {
    func deleteReview(commentId: Int, completionHandler: @escaping (AFDataResponse<DeleteProductReviewResult>) -> Void) {
        let requestModel = DeleteProductReview(baseUrl: baseUrl, commentId: commentId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension DeleteProductReview {
    struct DeleteProductReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "delete_product_review"
        
        let commentId: Int
        var parameters: Parameters? {
            return [
                "id_comment": commentId
            ]
        }
    }
}

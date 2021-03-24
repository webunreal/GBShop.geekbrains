//
//  GetCart.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 24.03.2021.
//

import Foundation
import Alamofire

class GetCart: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue,
        baseUrl: URL
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        self.baseUrl = baseUrl
    }
}

extension GetCart: GetCartRequestFactory {
    func getCart(
        userId: Int,
        completionHandler: @escaping (AFDataResponse<GetCartResult>) -> Void
    ) {
        let requestModel = GetCart(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension GetCart {
    struct GetCart: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "get_basket"
        
        let userId: Int
        var parameters: Parameters? {
            [
                "id_user": userId
            ]
        }
    }
}

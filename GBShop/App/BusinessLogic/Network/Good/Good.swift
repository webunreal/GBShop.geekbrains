//
//  Good.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 17.02.2021.
//

import Foundation
import Alamofire

class Good: AbstractRequestFactory {
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

extension Good: GoodRequestFactory {
    func getGood(productId: Int, completionHandler: @escaping (AFDataResponse<GoodResult>) -> Void) {
        let requestModel = Good(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Good {
    struct Good: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getGoodById.json"
        
        let productId: Int
        var parameters: Parameters? {
            return [
                "product_id" : productId
            ]
        }
    }
}

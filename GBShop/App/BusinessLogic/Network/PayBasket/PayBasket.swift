//
//  PayBasket.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import Foundation
import Alamofire

class PayBasket: AbstractRequestFactory {
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

extension PayBasket: PayBasketRequestFactory {
    func payBasket(
        userId: Int,
        completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void
    ) {
        let requestModel = PayBasket(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
        
        clearBasket()
    }
    
    private func clearBasket() {}
}

extension PayBasket {
    struct PayBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "pay_basket"
        
        let userId: Int
        var parameters: Parameters? {
            [
                "id_user": userId
            ]
        }
    }
}

//
//  AddToBasket.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import Foundation
import Alamofire

class AddToBasket: AbstractRequestFactory {
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

extension AddToBasket: AddToBasketRequestFactory {
    func addToBasket(
        productId: Int,
        quantity: Int,
        completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void
    ) {
        let requestModel = AddToBasket(baseUrl: baseUrl, productId: productId, quantity: 1)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension AddToBasket {
    struct AddToBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "add_to_basket"
        
        let productId: Int
        let quantity: Int
        var parameters: Parameters? {
            [
                "id_product": productId,
                "quantity": quantity
            ]
        }
    }
}

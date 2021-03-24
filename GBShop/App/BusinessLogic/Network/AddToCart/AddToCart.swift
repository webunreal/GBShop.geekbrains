//
//  AddToCart.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import Foundation
import Alamofire

class AddToCart: AbstractRequestFactory {
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

extension AddToCart: AddToCartRequestFactory {
    func addToCart(
        productId: Int,
        quantity: Int,
        completionHandler: @escaping (AFDataResponse<AddToCartResult>) -> Void
    ) {
        let requestModel = AddToCart(baseUrl: baseUrl, productId: productId, quantity: 1)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension AddToCart {
    struct AddToCart: RequestRouter {
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

//
//  DeleteFromCart.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import Foundation
import Alamofire

class DeleteFromCart: AbstractRequestFactory {
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

extension DeleteFromCart: DeleteFromCartRequestFactory {
    func deleteFromCart(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<DeleteFromCartResult>) -> Void
    ) {
        let requestModel = DeleteFromCart(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension DeleteFromCart {
    struct DeleteFromCart: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "delete_from_basket"
        
        let productId: Int
        var parameters: Parameters? {
            [
                "id_product": productId
            ]
        }
    }
}

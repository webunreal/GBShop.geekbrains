//
//  Product.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 17.02.2021.
//

import Foundation
import Alamofire

class Product: AbstractRequestFactory {
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

extension Product: ProductRequestFactory {
    func getProduct(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void
    ) {
        let requestModel = Product(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Product {
    struct Product: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "get_product"
        
        let productId: Int
        var parameters: Parameters? {
            [
                "id_product": productId
            ]
        }
    }
}

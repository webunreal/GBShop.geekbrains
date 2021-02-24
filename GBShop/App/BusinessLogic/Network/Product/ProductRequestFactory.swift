//
//  ProductRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 17.02.2021.
//

import Foundation
import Alamofire

protocol ProductRequestFactory {
    func getProduct(productId: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void)
}

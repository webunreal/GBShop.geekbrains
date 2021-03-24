//
//  AddTocartRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import Foundation
import Alamofire

protocol AddToCartRequestFactory {
    func addToCart(
        productId: Int,
        quantity: Int,
        completionHandler: @escaping (AFDataResponse<AddToCartResult>) -> Void
    )
}

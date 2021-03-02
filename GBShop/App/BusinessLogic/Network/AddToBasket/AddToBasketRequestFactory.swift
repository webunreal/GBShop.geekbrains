//
//  AddToBasketRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import Foundation
import Alamofire

protocol AddToBasketRequestFactory {
    func addToBasket(
        productId: Int,
        quantity: Int,
        completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void
    )
}

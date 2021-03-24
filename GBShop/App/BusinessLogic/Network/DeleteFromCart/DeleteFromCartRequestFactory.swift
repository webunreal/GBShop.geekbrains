//
//  DeleteFromCartRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import Foundation
import Alamofire

protocol DeleteFromCartRequestFactory {
    func deleteFromCart(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<DeleteFromCartResult>) -> Void
    )
}

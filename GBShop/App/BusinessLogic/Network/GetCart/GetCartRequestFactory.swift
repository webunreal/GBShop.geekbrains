//
//  GetCartRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 24.03.2021.
//

import Foundation
import Alamofire

protocol GetCartRequestFactory {
    func getCart(
        userId: Int,
        completionHandler: @escaping (AFDataResponse<GetCartResult>) -> Void
    )
}

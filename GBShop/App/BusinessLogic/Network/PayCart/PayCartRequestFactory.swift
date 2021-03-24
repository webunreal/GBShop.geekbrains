//
//  PayCartRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 02.03.2021.
//

import Foundation
import Alamofire

protocol PayCartRequestFactory {
    func payCart(
        userId: Int,
        completionHandler: @escaping (AFDataResponse<PayCartResult>) -> Void
    )
}

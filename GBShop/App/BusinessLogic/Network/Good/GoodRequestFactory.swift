//
//  GoodRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 17.02.2021.
//

import Foundation
import Alamofire

protocol GoodRequestFactory {
    func getGood(productId: Int, completionHandler: @escaping (AFDataResponse<GoodResult>) -> Void)
}

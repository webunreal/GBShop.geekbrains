//
//  LogOutRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 14.02.2021.
//

import Foundation
import Alamofire

protocol LogOutRequestFactory {
    func logOut(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LogOutResult>) -> Void)
}

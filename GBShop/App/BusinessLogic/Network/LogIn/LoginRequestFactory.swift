//
//  LogInRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 14.02.2021.
//

import Foundation
import Alamofire

protocol LogInRequestFactory {
    func logIn(login: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}

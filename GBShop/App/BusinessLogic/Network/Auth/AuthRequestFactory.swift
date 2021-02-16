//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 14.02.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(login: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}

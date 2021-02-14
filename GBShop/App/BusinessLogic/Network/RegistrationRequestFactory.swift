//
//  RegistrationRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 14.02.2021.
//

import Foundation
import Alamofire

protocol RegistrationRequestFactory {
    func register(userName: String, password: String, completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void)
}

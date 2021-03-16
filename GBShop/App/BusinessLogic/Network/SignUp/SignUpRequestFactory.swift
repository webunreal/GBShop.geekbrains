//
//  SignUpRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 14.02.2021.
//

import Foundation
import Alamofire

protocol SignUpRequestFactory {
    func signUp(
        userId: Int,
        login: String,
        password: String,
        email: String,
        gender: String,
        creditCard: String,
        bio: String,
        completionHandler: @escaping (AFDataResponse<SignUpResult>) -> Void
    )
}

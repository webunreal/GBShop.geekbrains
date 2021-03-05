//
//  ChangeUserDataRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 14.02.2021.
//

import Foundation
import Alamofire

protocol ChangeUserDataRequestFactory {
    func changeUserData(userId: Int,
                        login: String,
                        password: String,
                        email: String,
                        gender: String,
                        creditCard: String,
                        bio: String, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
}

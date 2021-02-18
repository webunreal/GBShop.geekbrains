//
//  ChangeUserDataRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 14.02.2021.
//

import Foundation
import Alamofire

protocol ChangeUserDataRequestFactory {
    func changeUserData(userName: String, password: String, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
}

//
//  UserInfo.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 12.03.2021.
//

import Foundation

final class UserInfo {
    public static let shared = UserInfo()
    private init() {}
    
    public var user = User(id: 1, login: "", name: "", lastname: "")
}

//
//  GetCartResult.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 24.03.2021.
//

import Foundation

struct GetCartResult: Codable {
    let amount: Int
    let countGoods: Int
    let contents: [CartProduct]
}

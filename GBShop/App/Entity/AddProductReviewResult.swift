//
//  AddProductReviewResult.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import Foundation

struct AddProductReviewResult: Codable {
    let result: Int
    let userMessage: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case userMessage = "user_message"
    }
}

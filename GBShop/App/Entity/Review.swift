//
//  Review.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import Foundation

struct Review: Codable {
    let commentId: Int
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case commentId = "id_comment"
        case text
    }
}

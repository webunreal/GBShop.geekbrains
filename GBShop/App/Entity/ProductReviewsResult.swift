//
//  ProductReviewsResult.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import Foundation

struct ProductReviewsResult: Codable {
    let pageNumber: Int
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page_number"
        case reviews
    }
}

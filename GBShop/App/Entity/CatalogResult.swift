//
//  CatalogResult.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 16.02.2021.
//

import Foundation

struct CatalogResult: Codable {
    let pageNumber: Int
    let products: [CatalogProduct]
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page_number"
        case products
    }
}

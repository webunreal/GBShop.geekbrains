//
//  CatalogProduct.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 26.02.2021.
//

import Foundation

struct CatalogProduct: Codable {
    let productId: Int
    let productName: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = "id_product"
        case productName = "product_name"
        case price
    }
}

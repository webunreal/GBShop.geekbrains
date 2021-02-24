//
//  CatalogRequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 16.02.2021.
//

import Foundation
import Alamofire

protocol CatalogRequestFactory {
    func getCatalog(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<CatalogResult>) -> Void)
}

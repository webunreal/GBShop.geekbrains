//
//  CatalogDataTests.swift
//  GBShopTests
//
//  Created by Nikolai Ivanov on 16.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class CatalogDataTests: XCTestCase {
    func testCatalogDataGetting() {
        let requestFactory = RequestFactory()
        let catalogData = requestFactory.makeCatalogRequestFactory()
        let fakeData = FakeData()
        let catalog = expectation(description: "Got Catalog")
        
        catalogData.getCatalog(pageNumber: fakeData.pageNumber,
                               categoryId: fakeData.categoryId) { response in
            switch response.result {
            case .success(let catalogResponse):
                XCTAssertEqual(catalogResponse.products[0].productId, 123)
                catalog.fulfill()

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}

//
//  RequestFactory.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 14.02.2021.
//

import Foundation
import Alamofire

class RequestFactory {
    
    private let baseUrl = URL(string: "https://protected-shelf-18561.herokuapp.com/")!
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .default)
    
    func makeLogInRequestFatory() -> LogInRequestFactory {
        let errorParser = makeErrorParser()
        return LogIn(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }
    
    func makeSignUpRequestFactory() -> SignUpRequestFactory {
        let errorParser = makeErrorParser()
        return SignUp(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }
    
    func makeChangeUserDataRequestFactory() -> ChangeUserDataRequestFactory {
        let errorParser = makeErrorParser()
        return ChangeUserData(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }
    
    func makeLogOutRequestFactory() -> LogOutRequestFactory {
        let errorParser = makeErrorParser()
        return LogOut(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }
    
    func makeCatalogRequestFactory() -> CatalogRequestFactory {
        let errorParser = makeErrorParser()
        return Catalog(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }
    
    func makeProductRequestFactory() -> ProductRequestFactory {
        let errorParser = makeErrorParser()
        return Product(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }
    
    func makeProductReviewsRequestFactory() -> ProductReviewsRequestFactory {
        let errorParser = makeErrorParser()
        return ProductReviews(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }
    
    func makeAddProductReviewRequestFactory() -> AddProductReviewRequestFactory {
        let errorParser = makeErrorParser()
        return AddProductReview(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }

    func makeApproveProductReviewRequestFactory() -> ApproveProductReviewRequestFactory {
        let errorParser = makeErrorParser()
        return ApproveProductReview(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }

    func makeDeleteProductReviewRequestFactory() -> DeleteProductReviewRequestFactory {
        let errorParser = makeErrorParser()
        return DeleteProductReview(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }
}

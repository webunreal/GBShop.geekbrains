//
//  AppAnalytics.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 25.03.2021.
//

import Foundation
import Firebase

struct AppAnalytics {
    
    public func successfulLogIn() {
        Analytics.logEvent(AnalyticsEventLogin, parameters: [
            AnalyticsParameterItemName: "Successful LogIn"
        ])
    }
    
    public func unsuccessfulLogIn() {
        Analytics.logEvent("Unsuccessful LogIn", parameters: [
            AnalyticsParameterItemName: "Unsuccessful LogIn"
        ])
    }
    
    public func logedOut() {
        Analytics.logEvent("Log Out", parameters: [
            AnalyticsParameterItemName: "Logged Out"
        ])
    }
    
    public func signedUp() {
        Analytics.logEvent(AnalyticsEventSignUp, parameters: [
            AnalyticsParameterItemName: "Signed Up"
        ])
    }
    
    public func productCatalogIsOpened() {
        Analytics.logEvent("Product Catalog Is Opened", parameters: [
            AnalyticsParameterItemName: "Product Catalog Is Opened"
        ])
    }
    
    public func concreteProductIsOpened(productName: String) {
        Analytics.logEvent("Concrete Product Is Opened", parameters: [
            AnalyticsParameterItemName: productName
        ])
    }
    
    public func productAddedToCart(productName: String) {
        Analytics.logEvent(AnalyticsEventAddToCart, parameters: [
            AnalyticsParameterItemName: productName
        ])
    }
    
    public func productIsDeletedFromCart(productName: String) {
        Analytics.logEvent(AnalyticsEventRemoveFromCart, parameters: [
            AnalyticsParameterItemName: productName
        ])
    }
    
    public func cartIsPaid() {
        Analytics.logEvent(AnalyticsEventPurchase, parameters: [
            AnalyticsParameterItemName: "Cart is Paid"
        ])
    }
    
    public func reviewIsAdded() {
        Analytics.logEvent("Review is added", parameters: [
            AnalyticsParameterItemName: "Review is added"
        ])
    }
}

//
//  LoginTests.swift
//  GBShopUITests
//
//  Created by Nikolai Ivanov on 22.03.2021.
//

import XCTest

class LoginTests: XCTestCase {
    
    func testLogin() {
        let app = XCUIApplication()
        app.launch()
        let scrollViewsQuery = app.scrollViews
        
        let loginTextField = scrollViewsQuery.textFields["Login"]
        loginTextField.tap()
        loginTextField.typeText("LOGIN")
        
        let passwordTextField = scrollViewsQuery.textFields["Password"]
        passwordTextField.tap()
        passwordTextField.typeText("PASSWORD")
        
        let loginButton = scrollViewsQuery.buttons["loginButton"]
        loginButton.tap()
    }
}

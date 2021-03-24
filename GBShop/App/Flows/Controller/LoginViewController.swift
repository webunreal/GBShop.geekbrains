//
//  LoginViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 07.03.2021.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private lazy var loginView: LoginView = {
        LoginView()
    }()
    
    private let requestFactory: RequestFactory
    
    // MARK: - Initialization
    
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        hideKeyboardWhenTappedAround()
        
        loginView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    @objc private func login() {
        if let login = loginView.loginTextField.text, let password = loginView.passwordTextField.text {
            let loginFactory = requestFactory.makeLogInRequestFatory()
            loginFactory.logIn(login: login, password: password) { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let login):
                        self.presentCatalogViewController(user: login.user)
                    case .failure(let error):
                        let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { _ in
                            self.login()
                        })
                        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    private func presentCatalogViewController(user: User) {
        let navigationController = UINavigationController(rootViewController: CatalogViewController(requestFactory: self.requestFactory, user: user))
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func signUp() {
        let userDataViewController = UserDataViewController(requestFactory: requestFactory, userDataControllerType: .signUp)
        userDataViewController.modalPresentationStyle = .fullScreen
        self.present(userDataViewController, animated: true, completion: nil)
    }
}

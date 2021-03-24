//
//  UserDataViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 07.03.2021.
//

import UIKit
import Alamofire

final class UserDataViewController: UIViewController {
    
    private let requestFactory: RequestFactory
    private let userDataControllerType: UserDataControllerType
    
    private lazy var userDataView: UserDataView = {
        UserDataView(userDataControllerType: userDataControllerType)
    }()
    
    // MARK: - Initialization
    
    init(requestFactory: RequestFactory, userDataControllerType: UserDataControllerType) {
        self.requestFactory = requestFactory
        self.userDataControllerType = userDataControllerType
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = userDataView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
        
        userDataView.proceedButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    @objc private func signUp() {
        if let username = userDataView.usernameTextField.text,
           let password = userDataView.passwordTextField.text,
           let email = userDataView.emailTextField.text,
           let creditCard = userDataView.creditCardTextField.text,
           let bio = userDataView.bioTextField.text {
            
            switch userDataControllerType {
            case .signUp:
                let signUpFactory = requestFactory.makeSignUpRequestFactory()
                signUpFactory.signUp(
                    userId: 123, login: username, password: password, email: email, gender: userDataView.gender, creditCard: creditCard, bio: bio) { [weak self] response in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        switch response.result {
                        case .success:
                            self.showLoginViewController()
                        case .failure(let error):
                            self.showErrorAlert(error: error)
                        }
                    }
                }
            case .changeUserData:
                let changeUserDataFactory = requestFactory.makeChangeUserDataRequestFactory()
                changeUserDataFactory.changeUserData(
                    userId: 123, login: username, password: password, email: email, gender: userDataView.gender, creditCard: creditCard, bio: bio) { [weak self] response in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        switch response.result {
                        case .success:
                            self.showLoginViewController()
                        case .failure(let error):
                            self.showErrorAlert(error: error)
                        }
                    }
                }
            }
        }
    }
    
    private func showLoginViewController() {
        let loginViewController = LoginViewController(requestFactory: requestFactory)
        loginViewController.modalPresentationStyle = .fullScreen
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    private func showErrorAlert(error: AFError) {
        let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { _ in
            self.signUp()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

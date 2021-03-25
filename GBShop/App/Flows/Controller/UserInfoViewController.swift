//
//  UserInfoViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 07.03.2021.
//

import UIKit

final class UserInfoViewController: UIViewController {
    
    private let requestFactory: RequestFactory
    private let user: User
    private let analytics = AppAnalytics()
    
    private lazy var userInfoView: UserInfoView = {
        UserInfoView()
    }()
    
    init(requestFactory: RequestFactory, user: User) {
        self.requestFactory = requestFactory
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Initialization
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = userInfoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "LogOut",
            style: .plain,
            target: self,
            action: #selector(logOut))
        
        userInfoView.usernameLabel.text = "Username: \(user.login)"
        userInfoView.firstNameLabel.text = "Name: \(user.name)"
        userInfoView.lastNameLabel.text = "Last name: \(user.lastname)"
        
        userInfoView.changeUserDataButton.addTarget(self, action: #selector(changeUserData), for: .touchUpInside)
    }
    
    @objc private func logOut() {
        let logOutFactory = requestFactory.makeLogOutRequestFactory()
        logOutFactory.logOut(userId: user.id) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    self.analytics.logedOut()
                    let loginViewController = LoginViewController(requestFactory: self.requestFactory)
                    loginViewController.modalPresentationStyle = .fullScreen
                    self.present(loginViewController, animated: true, completion: nil)
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { _ in
                        self.logOut()
                    })
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    @objc private func changeUserData() {
        let userDataViewController = UserDataViewController(requestFactory: requestFactory, userDataControllerType: .changeUserData)
        userDataViewController.modalPresentationStyle = .fullScreen
        self.present(userDataViewController, animated: true, completion: nil)
    }
}

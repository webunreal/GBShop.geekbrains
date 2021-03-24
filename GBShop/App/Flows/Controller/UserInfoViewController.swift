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
        
        userInfoView.usernameLabel.text = "Username: \(user.login)"
        userInfoView.firstNameLabel.text = "Name: \(user.name)"
        userInfoView.lastNameLabel.text = "Last name: \(user.lastname)"
        
        userInfoView.changeUserDataButton.addTarget(self, action: #selector(changeUserData), for: .touchUpInside)
    }

    @objc private func changeUserData() {
        let userDataViewController = UserDataViewController(requestFactory: requestFactory, userDataControllerType: .changeUserData)
        userDataViewController.modalPresentationStyle = .fullScreen
        self.present(userDataViewController, animated: true, completion: nil)
    }
}

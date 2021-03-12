//
//  UserInfoViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 07.03.2021.
//

import UIKit

class UserInfoViewController: UIViewController {
    public var user = UserInfo.shared.user
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Info"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    private var usernameLabel = UILabel()
    private var firstNameLabel = UILabel()
    private var lastNameLabel = UILabel()
    
    private let changeUserDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Change User Data", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(changeUserData), for: .touchUpInside)
        return button
    }()
    
    private let edgeSpace: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupViews()
        setupAutoLayout()
    }
    
    private func setupViews() {        
        view.backgroundColor = UIColor.white
        view.layoutIfNeeded()
        
        contentView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.frame.size.width,
            height: view.frame.size.height
        )
        
        usernameLabel = makeTextFieldTitle(text: "Username: \(user.login)")
        firstNameLabel = makeTextFieldTitle(text: "Name: \(user.name)")
        lastNameLabel = makeTextFieldTitle(text: "Last name: \(user.lastname)")
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(changeUserDataButton)
    }
    
    private func makeTextFieldTitle(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
    private func setupAutoLayout() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupTitleLabelConstraints()
        setupUsernameLabelConstraints()
        setupFirstNameLabelConstraints()
        setupLastNameLabelConstraints()
        setupChangeUserDataButtonConstraints()
    }
    
    private func setupScrollViewConstraints() {
        scrollView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0
        ).isActive = true
        scrollView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0
        ).isActive = true
        scrollView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0
        ).isActive = true
        scrollView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0
        ).isActive = true
    }
    
    private func setupContentViewConstraints() {
        contentView.topAnchor.constraint(
            equalTo: scrollView.topAnchor, constant: 0
        ).isActive = true
        contentView.leadingAnchor.constraint(
            equalTo: scrollView.leadingAnchor, constant: 0
        ).isActive = true
        contentView.trailingAnchor.constraint(
            equalTo: scrollView.trailingAnchor, constant: 0
        ).isActive = true
        contentView.bottomAnchor.constraint(
            equalTo: scrollView.bottomAnchor, constant: 0
        ).isActive = true
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor, constant: 20
        ).isActive = true
        titleLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        titleLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupUsernameLabelConstraints() {
        usernameLabel.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor, constant: 30
        ).isActive = true
        usernameLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        usernameLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupFirstNameLabelConstraints() {
        firstNameLabel.topAnchor.constraint(
            equalTo: usernameLabel.bottomAnchor, constant: 20
        ).isActive = true
        firstNameLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        firstNameLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupLastNameLabelConstraints() {
        lastNameLabel.topAnchor.constraint(
            equalTo: firstNameLabel.bottomAnchor, constant: 20
        ).isActive = true
        lastNameLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        lastNameLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupChangeUserDataButtonConstraints() {
        changeUserDataButton.topAnchor.constraint(
            equalTo: lastNameLabel.bottomAnchor, constant: 30
        ).isActive = true
        changeUserDataButton.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        changeUserDataButton.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
        changeUserDataButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func changeUserData() {
        let userDataViewController = UserDataViewController()
        userDataViewController.controllerType = .changeUserData
        userDataViewController.modalPresentationStyle = .fullScreen
        self.present(userDataViewController, animated: true, completion: nil)
    }
}

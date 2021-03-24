//
//  UserDataView.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 23.03.2021.
//

import UIKit

final class UserDataView: UIView {
    
    private let userDataControllerType: UserDataControllerType
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    private lazy var usernameTextFieldTitle: UILabel = {
        UILabel()
    }()
    
    private(set) lazy var usernameTextField: UITextField = {
        UITextField()
    }()
    
    private lazy var passwordTextFieldTitle: UILabel = {
        UILabel()
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        UITextField()
    }()
    
    private lazy var emailTextFieldTitle: UILabel = {
        UILabel()
    }()
    
    private(set) lazy var emailTextField: UITextField = {
        UITextField()
    }()
    
    private lazy var genderTitle: UILabel = {
        UILabel()
    }()
    
    private lazy var genderSegmentedControl: UISegmentedControl = {
        let genders = ["Male", "Female"]
        let segmentedControl = UISegmentedControl(items: genders)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = .systemBlue
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)],
            for: .normal
        )
        return segmentedControl
    }()
    
    public var gender: String {
        if genderSegmentedControl.selectedSegmentIndex == 0 {
            return "m"
        } else {
            return "f"
        }
    }
    
    private lazy var creditCardTextFieldTitle: UILabel = {
        UILabel()
    }()
    
    private(set) lazy var creditCardTextField: UITextField = {
        UITextField()
    }()
    
    private lazy var bioTextFieldTitle: UILabel = {
        UILabel()
    }()
    
    private(set) lazy var bioTextField: UITextField = {
        UITextField()
    }()
    
    private(set) lazy var proceedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 25
        return button
    }()
    
    private let textFieldHeight: CGFloat = 30
    private let edgeSpace: CGFloat = 20
    private let spaceBetweenTitleAndTextField: CGFloat = 5
    private let spaceBetweenTextFields: CGFloat = 10

    // MARK: - Initialization
    
    init(userDataControllerType: UserDataControllerType) {
        self.userDataControllerType = userDataControllerType
        super.init(frame: .zero)
        configure()
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configure() {
        switch userDataControllerType {
        case .signUp:
            titleLabel.text = "SignUp"
            proceedButton.setTitle("SignUp", for: .normal)
        case .changeUserData:
            titleLabel.text = "Change User Data"
            proceedButton.setTitle("Save", for: .normal)
        }
        
        usernameTextFieldTitle = makeTextFieldTitle(title: "Username")
        usernameTextField = makeTextField(placeholder: "Username")
        
        passwordTextFieldTitle = makeTextFieldTitle(title: "Password")
        passwordTextField = makeTextField(placeholder: "Password")
        
        emailTextFieldTitle = makeTextFieldTitle(title: "Email")
        emailTextField = makeTextField(placeholder: "Email")
        
        genderTitle = makeTextFieldTitle(title: "Gender")
        
        creditCardTextFieldTitle = makeTextFieldTitle(title: "Credit Card")
        creditCardTextField = makeTextField(placeholder: "Credit Card")
        
        bioTextFieldTitle = makeTextFieldTitle(title: "Bio")
        bioTextField = makeTextField(placeholder: "Bio")
      
        setupViews()
        setupAutoLayout()
    }
    
    private func makeTextFieldTitle(title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }
    
    private func makeTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textColor = .gray
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = textFieldHeight / 2
        textField.leadingTextPadding(10)
        textField.trailingTextPadding(10)
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        return textField
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(usernameTextFieldTitle)
        contentView.addSubview(usernameTextField)
        contentView.addSubview(passwordTextFieldTitle)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(emailTextFieldTitle)
        contentView.addSubview(emailTextField)
        contentView.addSubview(genderTitle)
        contentView.addSubview(genderSegmentedControl)
        contentView.addSubview(creditCardTextFieldTitle)
        contentView.addSubview(creditCardTextField)
        contentView.addSubview(bioTextFieldTitle)
        contentView.addSubview(bioTextField)
        contentView.addSubview(proceedButton)
    }
    
    private func setupAutoLayout() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupTitleLabelConstraints()
        setupUsernameTextFieldTitleConstrains()
        setupUsernameTextFieldConstrains()
        setupPasswordTextFieldTitleConstrains()
        setupPasswordTextFieldConstrains()
        setupEmailTextFieldTitleConstrains()
        setupEmailTextFieldConstrains()
        setupGenderTitleConstrains()
        setupGenderSegmentedControlConstrains()
        setupCreditCardTextFieldTitleConstrains()
        setupCreditCardTextFieldConstrains()
        setupBioTextFieldTitleConstrains()
        setupBioTextFieldConstrains()
        setupSignUpButtonConstrains()
    }
    
    private func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace)
        ])
    }
    
    private func setupUsernameTextFieldTitleConstrains() {
        NSLayoutConstraint.activate([
            usernameTextFieldTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            usernameTextFieldTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            usernameTextFieldTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupUsernameTextFieldConstrains() {
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: usernameTextFieldTitle.bottomAnchor, constant: spaceBetweenTitleAndTextField),
            usernameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            usernameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace),
            usernameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
    }
    
    private func setupPasswordTextFieldTitleConstrains() {
        NSLayoutConstraint.activate([
            passwordTextFieldTitle.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: spaceBetweenTextFields),
            passwordTextFieldTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            passwordTextFieldTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupPasswordTextFieldConstrains() {
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldTitle.bottomAnchor, constant: spaceBetweenTitleAndTextField),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace),
            passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
    }
    
    private func setupEmailTextFieldTitleConstrains() {
        NSLayoutConstraint.activate([
            emailTextFieldTitle.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: spaceBetweenTextFields),
            emailTextFieldTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            emailTextFieldTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupEmailTextFieldConstrains() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldTitle.bottomAnchor, constant: spaceBetweenTitleAndTextField),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace),
            emailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
    }
    
    private func setupGenderTitleConstrains() {
        NSLayoutConstraint.activate([
            genderTitle.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: spaceBetweenTextFields),
            genderTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            genderTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupGenderSegmentedControlConstrains() {
        NSLayoutConstraint.activate([
            genderSegmentedControl.topAnchor.constraint(equalTo: genderTitle.bottomAnchor, constant: spaceBetweenTitleAndTextField),
            genderSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            genderSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupCreditCardTextFieldTitleConstrains() {
        NSLayoutConstraint.activate([
            creditCardTextFieldTitle.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: spaceBetweenTextFields),
            creditCardTextFieldTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            creditCardTextFieldTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupCreditCardTextFieldConstrains() {
        NSLayoutConstraint.activate([
            creditCardTextField.topAnchor.constraint(equalTo: creditCardTextFieldTitle.bottomAnchor, constant: spaceBetweenTitleAndTextField),
            creditCardTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            creditCardTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace),
            creditCardTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
    }
    
    private func setupBioTextFieldTitleConstrains() {
        NSLayoutConstraint.activate([
            bioTextFieldTitle.topAnchor.constraint(equalTo: creditCardTextField.bottomAnchor, constant: spaceBetweenTextFields),
            bioTextFieldTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            bioTextFieldTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupBioTextFieldConstrains() {
        NSLayoutConstraint.activate([
            bioTextField.topAnchor.constraint(equalTo: bioTextFieldTitle.bottomAnchor, constant: spaceBetweenTitleAndTextField),
            bioTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            bioTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace),
            bioTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
    }
    
    private func setupSignUpButtonConstrains() {
        NSLayoutConstraint.activate([
            proceedButton.topAnchor.constraint(equalTo: bioTextField.bottomAnchor, constant: 30),
            proceedButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            proceedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace),
            proceedButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

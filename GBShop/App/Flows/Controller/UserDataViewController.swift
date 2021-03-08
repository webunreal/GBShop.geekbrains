//
//  UserDataViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 07.03.2021.
//

import UIKit
import Alamofire

class UserDataViewController: UIViewController {
    public enum ControllerType {
        case signUp
        case changeUserData
    }
    
    public var controllerType: ControllerType?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    private var usernameTextFieldTitle = UILabel()
    private var usernameTextField = UITextField()
    
    private var passwordTextFieldTitle = UILabel()
    private var passwordTextField = UITextField()
    
    private var emailTextFieldTitle = UILabel()
    private var emailTextField = UITextField()
    
    private var genderTitle = UILabel()
    private let genderSegmentedControl: UISegmentedControl = {
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
    private var gender: String {
        if genderSegmentedControl.selectedSegmentIndex == 0 {
            return "m"
        } else {
            return "f"
        }
    }
    
    private var creditCardTextFieldTitle = UILabel()
    private var creditCardTextField = UITextField()
    
    private var bioTextFieldTitle = UILabel()
    private var bioTextField = UITextField()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    private let textFieldHeight: CGFloat = 30
    private let edgeSpace: CGFloat = 20
    private let spaceBetweenTitleAndTextField: CGFloat = 5
    private let spaceBetweenTextFields: CGFloat = 10
    private let requestFactory = RequestFactory()
    
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
        
        switch controllerType {
        case .signUp:
            titleLabel.text = "SignUp"
            signUpButton.setTitle("SignUp", for: .normal)
        case .changeUserData:
            titleLabel.text = "Change User Data"
            signUpButton.setTitle("Save", for: .normal)
        case .none:
            break
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
        
        view.addSubview(scrollView)
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
        contentView.addSubview(signUpButton)
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
    }
    
    private func setupUsernameTextFieldTitleConstrains() {
        usernameTextFieldTitle.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor, constant: 30
        ).isActive = true
        usernameTextFieldTitle.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        usernameTextFieldTitle.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupUsernameTextFieldConstrains() {
        usernameTextField.topAnchor.constraint(
            equalTo: usernameTextFieldTitle.bottomAnchor, constant: spaceBetweenTitleAndTextField
        ).isActive = true
        usernameTextField.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        usernameTextField.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    private func setupPasswordTextFieldTitleConstrains() {
        passwordTextFieldTitle.topAnchor.constraint(
            equalTo: usernameTextField.bottomAnchor, constant: spaceBetweenTextFields
        ).isActive = true
        passwordTextFieldTitle.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        passwordTextFieldTitle.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupPasswordTextFieldConstrains() {
        passwordTextField.topAnchor.constraint(
            equalTo: passwordTextFieldTitle.bottomAnchor, constant: spaceBetweenTitleAndTextField
        ).isActive = true
        passwordTextField.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        passwordTextField.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    private func setupEmailTextFieldTitleConstrains() {
        emailTextFieldTitle.topAnchor.constraint(
            equalTo: passwordTextField.bottomAnchor, constant: spaceBetweenTextFields
        ).isActive = true
        emailTextFieldTitle.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        emailTextFieldTitle.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupEmailTextFieldConstrains() {
        emailTextField.topAnchor.constraint(
            equalTo: emailTextFieldTitle.bottomAnchor, constant: spaceBetweenTitleAndTextField
        ).isActive = true
        emailTextField.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        emailTextField.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    private func setupGenderTitleConstrains() {
        genderTitle.topAnchor.constraint(
            equalTo: emailTextField.bottomAnchor, constant: spaceBetweenTextFields
        ).isActive = true
        genderTitle.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        genderTitle.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupGenderSegmentedControlConstrains() {
        genderSegmentedControl.topAnchor.constraint(
            equalTo: genderTitle.bottomAnchor, constant: spaceBetweenTitleAndTextField
        ).isActive = true
        genderSegmentedControl.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        genderSegmentedControl.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupCreditCardTextFieldTitleConstrains() {
        creditCardTextFieldTitle.topAnchor.constraint(
            equalTo: genderSegmentedControl.bottomAnchor, constant: spaceBetweenTextFields
        ).isActive = true
        creditCardTextFieldTitle.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        creditCardTextFieldTitle.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupCreditCardTextFieldConstrains() {
        creditCardTextField.topAnchor.constraint(
            equalTo: creditCardTextFieldTitle.bottomAnchor, constant: spaceBetweenTitleAndTextField
        ).isActive = true
        creditCardTextField.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        creditCardTextField.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
        creditCardTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    private func setupBioTextFieldTitleConstrains() {
        bioTextFieldTitle.topAnchor.constraint(
            equalTo: creditCardTextField.bottomAnchor, constant: spaceBetweenTextFields
        ).isActive = true
        bioTextFieldTitle.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        bioTextFieldTitle.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupBioTextFieldConstrains() {
        bioTextField.topAnchor.constraint(
            equalTo: bioTextFieldTitle.bottomAnchor, constant: spaceBetweenTitleAndTextField
        ).isActive = true
        bioTextField.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        bioTextField.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
        bioTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    private func setupSignUpButtonConstrains() {
        signUpButton.topAnchor.constraint(
            equalTo: bioTextField.bottomAnchor, constant: 30
        ).isActive = true
        signUpButton.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        signUpButton.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func signUp() {
        if let username = usernameTextField.text, let password = passwordTextField.text, let email = emailTextField.text, let creditCard = creditCardTextField.text, let bio = bioTextField.text {
            switch controllerType {
            case .signUp:
                let signUpFactory = requestFactory.makeSignUpRequestFactory()
                signUpFactory.signUp(userId: 123, login: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio) { response in
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
                changeUserDataFactory.changeUserData(userId: 123, login: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio) { response in
                    DispatchQueue.main.async {
                        switch response.result {
                        case .success:
                            self.showLoginViewController()
                        case .failure(let error):
                            self.showErrorAlert(error: error)
                        }
                    }
                }
            case .none:
                return
            }
        }
    }
    
    private func showLoginViewController() {
        let loginViewController = LoginViewController()
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

//
//  LoginViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 07.03.2021.
//

import UIKit

class LoginViewController: UIViewController {
    private let requestFactory: RequestFactory
    
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let logo: UIImageView = {
        if let image = UIImage(named: "logo") {
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
        return UIImageView()
    }()
    
    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "or"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemBlue
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    private var textFieldHeight: CGFloat = 40

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
        loginTextField = makeTextField(placeholder: "Login")
        passwordTextField = makeTextField(placeholder: "Password")
         
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logo)
        contentView.addSubview(loginTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)
        contentView.addSubview(orLabel)
        contentView.addSubview(signUpButton)
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
        setupLogoConstraints()
        setupLoginTextFieldConstraints()
        setupPasswordTextFieldConstraints()
        setupLoginButtonConstraints()
        setupOrLabelConstraints()
        setupSignUpButtonConstraints()
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
    
    private func setupLogoConstraints() {
        logo.centerXAnchor.constraint(
            equalTo: contentView.centerXAnchor
        ).isActive = true
        logo.topAnchor.constraint(
            equalTo: contentView.topAnchor, constant: 100
        ).isActive = true
        logo.heightAnchor.constraint(
            equalToConstant: UIScreen.main.bounds.height / 12
        ).isActive = true
    }
    
    private func setupLoginTextFieldConstraints() {
        loginTextField.topAnchor.constraint(
            equalTo: logo.bottomAnchor, constant: 50
        ).isActive = true
        loginTextField.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 50
        ).isActive = true
        loginTextField.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -50
        ).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    private func setupPasswordTextFieldConstraints() {
        passwordTextField.topAnchor.constraint(
            equalTo: loginTextField.bottomAnchor, constant: 20
        ).isActive = true
        passwordTextField.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 50
        ).isActive = true
        passwordTextField.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -50
        ).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    private func setupLoginButtonConstraints() {
        loginButton.topAnchor.constraint(
            equalTo: passwordTextField.bottomAnchor, constant: 30
        ).isActive = true
        loginButton.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 50
        ).isActive = true
        loginButton.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -50
        ).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupOrLabelConstraints() {
        orLabel.topAnchor.constraint(
            equalTo: loginButton.bottomAnchor, constant: 10
        ).isActive = true
        orLabel.centerXAnchor.constraint(
            equalTo: contentView.centerXAnchor
        ).isActive = true
    }
    
    private func setupSignUpButtonConstraints() {
        signUpButton.topAnchor.constraint(
            equalTo: orLabel.bottomAnchor, constant: 0
        ).isActive = true
        signUpButton.centerXAnchor.constraint(
            equalTo: contentView.centerXAnchor
        ).isActive = true
    }
    
    @objc private func login() {
        if let login = loginTextField.text, let password = passwordTextField.text {
            let loginFactory = requestFactory.makeLogInRequestFatory()
            loginFactory.logIn(login: login, password: password) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let login):
                        let user = login.user
                        let navigationController = UINavigationController(rootViewController: CatalogViewController(requestFactory: self.requestFactory, user: user))
                        navigationController.modalPresentationStyle = .fullScreen
                        self.present(navigationController, animated: true, completion: nil)
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
    
    @objc private func signUp() {
        let userDataViewController = UserDataViewController(requestFactory: requestFactory, userDataControllerType: .signUp)
        userDataViewController.modalPresentationStyle = .fullScreen
        self.present(userDataViewController, animated: true, completion: nil)
    }
}

//
//  UserInfoView.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 23.03.2021.
//

import UIKit

final class UserInfoView: UIView {
    
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
        label.text = "Info"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    private(set) lazy var usernameLabel: UILabel = {
        UILabel()
    }()
    
    private(set) lazy var firstNameLabel: UILabel = {
        UILabel()
    }()
    
    private(set) lazy var lastNameLabel: UILabel = {
        UILabel()
    }()
    
    private(set) lazy var changeUserDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Change User Data", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 25
        return button
    }()
    
    private let edgeSpace: CGFloat = 20
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configure() {
        usernameLabel = makeLabel()
        firstNameLabel = makeLabel()
        lastNameLabel = makeLabel()
        
        setupViews()
        setupAutoLayout()
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(changeUserDataButton)
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
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupUsernameLabelConstraints() {
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupFirstNameLabelConstraints() {
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            firstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            firstNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupLastNameLabelConstraints() {
        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 20),
            lastNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            lastNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupChangeUserDataButtonConstraints() {
        NSLayoutConstraint.activate([
            changeUserDataButton.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 30),
            changeUserDataButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeSpace),
            changeUserDataButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeSpace),
            changeUserDataButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

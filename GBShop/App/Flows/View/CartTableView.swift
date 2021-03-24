//
//  CartTableView.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 23.03.2021.
//

import UIKit

final class CartTableView: UIView {

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private(set) var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private(set) var productsQuantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private(set) var payCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Pay Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 25
        return button
    }()
    
    private let edgeSpace: CGFloat = 10

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
        setupViews()
        setupAutoLayout()
    }
    
    private func setupViews() {
        addSubview(tableView)
        addSubview(footerView)
        footerView.addSubview(amountLabel)
        footerView.addSubview(productsQuantityLabel)
        footerView.addSubview(payCartButton)
    }
    
    private func setupAutoLayout() {
        setuptableViewConstraints()
        setupFooterViewConstraints()
        setupAmountLabelConstraints()
        setupProductsQuantityLabelConstraints()
        setupPayCartButtonConstraints()
    }
    
    private func setuptableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor)
        ])
    }
    
    private func setupFooterViewConstraints() {
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupAmountLabelConstraints() {
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20),
            amountLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: edgeSpace),
            amountLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupProductsQuantityLabelConstraints() {
        NSLayoutConstraint.activate([
            productsQuantityLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 10),
            productsQuantityLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: edgeSpace),
            productsQuantityLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupPayCartButtonConstraints() {
        NSLayoutConstraint.activate([
            payCartButton.topAnchor.constraint(equalTo: productsQuantityLabel.bottomAnchor, constant: 10),
            payCartButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: edgeSpace),
            payCartButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -edgeSpace),
            payCartButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -edgeSpace),
            payCartButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

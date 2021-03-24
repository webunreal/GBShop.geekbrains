//
//  ProductTableView.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 23.03.2021.
//

import UIKit

final class ProductTableView: UIView {

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    private(set) lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private(set) lazy var addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 25
        return button
    }()
    
    private lazy var reviewsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reviews"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
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
        tableView.tableHeaderView = headerView
        headerView.addSubview(titleLabel)
        headerView.addSubview(priceLabel)
        headerView.addSubview(addToCartButton)
        headerView.addSubview(reviewsTitleLabel)
        
        tableView.tableHeaderView?.layoutIfNeeded()
        tableView.tableHeaderView = tableView.tableHeaderView
    }
    
    private func setupAutoLayout() {
        setuptableViewConstraints()
        setupHeaderViewConstraints()
        setupTitleLabelConstraints()
        setupPriceLabelConstraints()
        setupAddToCartConstrainsts()
        setupReviewsTitleLabelConstraints()
    }
    
    private func setuptableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func setupHeaderViewConstraints() {
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            headerView.topAnchor.constraint(equalTo: tableView.topAnchor)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: edgeSpace),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupPriceLabelConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: edgeSpace),
            priceLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -edgeSpace)
        ])
    }
    
    private func setupAddToCartConstrainsts() {
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            addToCartButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: edgeSpace),
            addToCartButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -edgeSpace),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupReviewsTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            reviewsTitleLabel.topAnchor.constraint(equalTo: addToCartButton.bottomAnchor, constant: 20),
            reviewsTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: edgeSpace),
            reviewsTitleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -edgeSpace),
            reviewsTitleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
        ])
    }
}

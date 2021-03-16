//
//  ProductViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 16.03.2021.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {    
    private let requestFactory: RequestFactory
    private let product: CatalogProduct
    
    init(requestFactory: RequestFactory, product: CatalogProduct) {
        self.requestFactory = requestFactory
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView = UITableView()
    private var productReviews: [Review] = []
    private let catalogCellReusableIdentifier = "ProductReviewTableViewCell"
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()
    
    private let reviewsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reviews"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private let edgeSpace: CGFloat = 10
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async {
            self.tableView.tableHeaderView?.layoutIfNeeded()
            self.tableView.tableHeaderView = self.tableView.tableHeaderView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductReviewTableViewCell.self as AnyClass, forCellReuseIdentifier: catalogCellReusableIdentifier)
        setupViews()
        setupAutoLayout()
        getProductReviews()
    }
    
    private func setupViews() {
        title = product.productName
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        view.backgroundColor = UIColor.white
        
        titleLabel.text = product.productName
        priceLabel.text = String(product.price) + " ₽"
        
        view.backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        headerView.addSubview(titleLabel)
        headerView.addSubview(priceLabel)
        headerView.addSubview(reviewsTitleLabel)
        
        tableView.tableHeaderView?.layoutIfNeeded()
        tableView.tableHeaderView = tableView.tableHeaderView
    }
    
    private func setupAutoLayout() {
        setupTableViewConstraints()
        setupHeaderViewConstraints()
        setupTitleLabelConstraints()
        setupPriceLabelConstraints()
        setupReviewsTitleLabelConstraints()
    }
    
    private func setupTableViewConstraints() {
        tableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0
        ).isActive = true
        tableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0
        ).isActive = true
        tableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0
        ).isActive = true
        tableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0
        ).isActive = true
    }
    
    private func setupHeaderViewConstraints() {
        headerView.centerXAnchor.constraint(
            equalTo: self.tableView.centerXAnchor
        ).isActive = true
        headerView.widthAnchor.constraint(
            equalTo: self.tableView.widthAnchor
        ).isActive = true
        headerView.topAnchor.constraint(
            equalTo: self.tableView.topAnchor
        ).isActive = true
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.topAnchor.constraint(
            equalTo: headerView.topAnchor, constant: 20
        ).isActive = true
        titleLabel.leadingAnchor.constraint(
            equalTo: headerView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        titleLabel.trailingAnchor.constraint(
            equalTo: headerView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupPriceLabelConstraints() {
        priceLabel.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor, constant: 10
        ).isActive = true
        priceLabel.leadingAnchor.constraint(
            equalTo: headerView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        priceLabel.trailingAnchor.constraint(
            equalTo: headerView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
    }
    
    private func setupReviewsTitleLabelConstraints() {
        reviewsTitleLabel.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor, constant: 20
        ).isActive = true
        reviewsTitleLabel.leadingAnchor.constraint(
            equalTo: headerView.leadingAnchor, constant: edgeSpace
        ).isActive = true
        reviewsTitleLabel.trailingAnchor.constraint(
            equalTo: headerView.trailingAnchor, constant: -edgeSpace
        ).isActive = true
        reviewsTitleLabel.bottomAnchor.constraint(
            equalTo: headerView.bottomAnchor, constant: -10
        ).isActive = true
    }
    
    private func getProductReviews() {
        let productReviewsFactory = requestFactory.makeProductReviewsRequestFactory()
        productReviewsFactory.getReviews(productId: product.productId) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let reviews):
                    self.productReviews = reviews.reviews
                    self.tableView.reloadData()
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { _ in
                        self.getProductReviews()
                    })
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: catalogCellReusableIdentifier, for: indexPath) as? ProductReviewTableViewCell
        else { return UITableViewCell(style: .default, reuseIdentifier: "") }
        
        if !productReviews.isEmpty {
            cell.userNameLabel.text = "User: " + String(productReviews[indexPath.row].userId)
            cell.reviewTextLabel.text = productReviews[indexPath.row].text
        }
        return cell
    }
}

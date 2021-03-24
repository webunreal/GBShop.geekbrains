//
//  ProductViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 16.03.2021.
//

import UIKit

final class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let requestFactory: RequestFactory
    private let product: CatalogProduct
    private var productReviews: [Review] = []
    private let catalogCellReusableIdentifier = "ProductReviewTableViewCell"
    private lazy var productTableView: ProductTableView = {
        ProductTableView()
    }()
    
    init(requestFactory: RequestFactory, product: CatalogProduct) {
        self.requestFactory = requestFactory
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = productTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = product.productName
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        view.backgroundColor = UIColor.white
        
        productTableView.tableView.delegate = self
        productTableView.tableView.dataSource = self
        productTableView.tableView.register(ProductReviewTableViewCell.self as AnyClass, forCellReuseIdentifier: catalogCellReusableIdentifier)

        productTableView.titleLabel.text = product.productName
        productTableView.priceLabel.text = String(product.price) + " ₽"
        productTableView.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        getProductReviews()
    }
    
    @objc func addToCart(sender: UIButton) {
        let addTocartFactory = requestFactory.makeAddToCartRequestFactory()
        addTocartFactory.addToCart(productId: product.productId, quantity: 1) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    self.productTableView.tableView.reloadData()
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func getProductReviews() {
        let productReviewsFactory = requestFactory.makeProductReviewsRequestFactory()
        productReviewsFactory.getReviews(productId: product.productId) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let reviews):
                    self.productReviews = reviews.reviews
                    self.productTableView.tableView.reloadData()
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

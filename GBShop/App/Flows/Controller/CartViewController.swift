//
//  CartViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 23.03.2021.
//

import UIKit

final class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let requestFactory: RequestFactory
    private let user: User
    private let cartCellReusableIdentifier = "CartTableViewCell"
    private var cart: GetCartResult?
    private lazy var cartTableView: CartTableView = {
        CartTableView()
    }()
    
    init(requestFactory: RequestFactory, user: User) {
        self.requestFactory = requestFactory
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = cartTableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        view.backgroundColor = UIColor.white
        
        cartTableView.tableView.delegate = self
        cartTableView.tableView.dataSource = self
        cartTableView.tableView.register(CartTableViewCell.self as AnyClass, forCellReuseIdentifier: cartCellReusableIdentifier)
        
        self.cartTableView.payCartButton.addTarget(self, action: #selector(payCart), for: .touchUpInside)
        
        getCart()
    }
    
    @objc private func payCart() {
        let payCartFactory = requestFactory.makePayCartRequestFactory()
        payCartFactory.payCart(userId: user.id) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    let navigationController = UINavigationController(rootViewController: CatalogViewController(requestFactory: self.requestFactory, user: self.user))
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true, completion: nil)
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { _ in
                        self.payCart()
                    })
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func getCart() {
        let getCartFactory = requestFactory.makeGetCartRequestFactory()
        getCartFactory.getCart(userId: user.id) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let cart):
                    self.cart = cart
                    self.setupLabels()
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { _ in
                        self.getCart()
                    })
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func setupLabels() {
        cartTableView.amountLabel.text = "Total: \(cart?.amount ?? 0) ₽"
        cartTableView.productsQuantityLabel.text = "Products in Cart: \(cart?.countGoods ?? 0)"
        cartTableView.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cart?.contents.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cartCellReusableIdentifier, for: indexPath) as? CartTableViewCell,
        let cartProducts = cart?.contents
        else { return UITableViewCell(style: .default, reuseIdentifier: "") }
        
        if !cartProducts.isEmpty {
            cell.productNameLabel.text = cartProducts[indexPath.row].productName
            cell.productPriceLabel.text = String(cartProducts[indexPath.row].price) + " ₽"
        }
        return cell
    }

}

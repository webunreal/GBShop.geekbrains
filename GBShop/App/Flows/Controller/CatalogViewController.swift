//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 12.03.2021.
//

import UIKit

final class CatalogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let requestFactory: RequestFactory
    private let user: User
    private var catalog: [CatalogProduct] = []
    private let catalogCellReusableIdentifier = "CatalogTableViewCell"
    private lazy var catalogTableView: CatalogTableView = {
        CatalogTableView()
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
        view = catalogTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Catalog"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "cart"),
            style: .plain,
            target: self,
            action: #selector(showCart))
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person"),
            style: .plain,
            target: self,
            action: #selector(showUserInfo))
        
        catalogTableView.tableView.delegate = self
        catalogTableView.tableView.dataSource = self
        catalogTableView.tableView.register(CatalogTableViewCell.self as AnyClass, forCellReuseIdentifier: catalogCellReusableIdentifier)
        getProducts(pageNumber: 1, categoryId: 1)  
    }
    
    private func getProducts(pageNumber: Int, categoryId: Int) {
        let catalogFactory = requestFactory.makeCatalogRequestFactory()
        catalogFactory.getCatalog(pageNumber: pageNumber, categoryId: categoryId) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let products):
                    self.catalog = products.products
                    self.catalogTableView.tableView.reloadData()
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { _ in
                        self.getProducts(pageNumber: pageNumber, categoryId: categoryId)
                    })
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func showCart() {
        let cartViewController = CartViewController(requestFactory: requestFactory, user: user)
        navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    @objc private func showUserInfo() {
        let userInfoViewController = UserInfoViewController(requestFactory: requestFactory, user: user)
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productViewController = ProductViewController(requestFactory: requestFactory, product: catalog[indexPath.row])
        navigationController?.pushViewController(productViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        catalog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: catalogCellReusableIdentifier, for: indexPath) as? CatalogTableViewCell
        else { return UITableViewCell(style: .default, reuseIdentifier: "") }
        
        if !catalog.isEmpty {
            cell.productNameLabel.text = catalog[indexPath.row].productName
            cell.productPriceLabel.text = String(catalog[indexPath.row].price) + " ₽"
            
            cell.cartButton.tag = indexPath.row
            cell.cartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        }
        return cell
    }
    
    @objc func addToCart(sender: UIButton) {
        let addTocartFactory = requestFactory.makeAddToCartRequestFactory()
        addTocartFactory.addToCart(productId: catalog[sender.tag].productId, quantity: 1) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    self.catalogTableView.tableView.reloadData()
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

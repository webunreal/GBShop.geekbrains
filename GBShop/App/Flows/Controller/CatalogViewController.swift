//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 12.03.2021.
//

import UIKit

class CatalogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let requestFactory: RequestFactory
    private let user: User
    
    init(requestFactory: RequestFactory, user: User) {
        self.requestFactory = requestFactory
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView = UITableView()
    private var catalog: [CatalogProduct] = []
    private let catalogCellReusableIdentifier = "CatalogTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CatalogTableViewCell.self as AnyClass, forCellReuseIdentifier: catalogCellReusableIdentifier)
        setupViews()
        setupAutoLayout()
        getProducts(pageNumber: 1, categoryId: 1)
    }
    
    private func setupViews() {
        title = "Catalog"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person"),
            style: .plain,
            target: self,
            action: #selector(showUserInfo)
        )
        view.backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
    }
    
    private func setupAutoLayout() {
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
    
    private func getProducts(pageNumber: Int, categoryId: Int) {
        let catalogFactory = requestFactory.makeCatalogRequestFactory()
        catalogFactory.getCatalog(pageNumber: pageNumber, categoryId: categoryId) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let products):
                    self.catalog = products.products
                    self.tableView.reloadData()
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
        }
        return cell
    }
}

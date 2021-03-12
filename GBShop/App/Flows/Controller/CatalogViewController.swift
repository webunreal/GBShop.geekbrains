//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 12.03.2021.
//

import UIKit

class CatalogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView()
    private var catalog: [CatalogProduct] = []
    private let catalogCellReusableIdentifier = "CatalogTableViewCell"
    private let requestFactory = RequestFactory()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CatalogTableViewCell.self as AnyClass, forCellReuseIdentifier: catalogCellReusableIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        setupViews()
        setupAutoLayout()
        getProducts()
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
    
    private func getProducts() {
        let catalogFactory = requestFactory.makeCatalogRequestFactory()
        catalogFactory.getCatalog(pageNumber: 1, categoryId: 1) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let products):
                    self.catalog = products.products
                    self.tableView.reloadData()
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { _ in
                        self.getProducts()
                    })
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func showUserInfo() {
        let userInfoViewController = UserInfoViewController()
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        catalog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: catalogCellReusableIdentifier, for: indexPath) as? CatalogTableViewCell
        else { return UITableViewCell(style: .default, reuseIdentifier: "") }
        
        if !catalog.isEmpty {
            cell.productNameLabel.text = catalog[indexPath.row].productName
            cell.productPriceLabel.text = String(catalog[indexPath.row].price)
        }
        return cell
    }
}

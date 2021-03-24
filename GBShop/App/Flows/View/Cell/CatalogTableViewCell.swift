//
//  CatalogTableViewCell.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 12.03.2021.
//

import UIKit

final class CatalogTableViewCell: UITableViewCell {
    
    private(set) lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private(set) lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()
    
    private(set) lazy var cartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonImage = UIImage(systemName: "cart.badge.plus")?.withRenderingMode(.alwaysTemplate)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(cartButton)
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        setupProductNameLabelConstrains()
        setupProductPriceLabelConstrains()
        setupCartButtonConstrains()
    }
    
    private func setupProductNameLabelConstrains() {
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productNameLabel.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: -10)
        ])
    }
    
    private func setupProductPriceLabelConstrains() {
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productPriceLabel.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: -10),
            productPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupCartButtonConstrains() {
        NSLayoutConstraint.activate([
            cartButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            cartButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

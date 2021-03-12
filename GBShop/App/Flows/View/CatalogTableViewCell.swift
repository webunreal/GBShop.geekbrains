//
//  CatalogTableViewCell.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 12.03.2021.
//

import UIKit

class CatalogTableViewCell: UITableViewCell {
    public var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    public var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white

        contentView.addSubview(productNameLabel)
        contentView.addSubview(productPriceLabel)
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        setupProductNameLabelConstrains()
        setupProductPriceLabelConstrains()
    }

    private func setupProductNameLabelConstrains() {
        productNameLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor, constant: 10
        ).isActive = true
        productNameLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 10
        ).isActive = true
        productNameLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: 10
        ).isActive = true
    }
    
    private func setupProductPriceLabelConstrains() {
        productPriceLabel.topAnchor.constraint(
            equalTo: productNameLabel.bottomAnchor, constant: 10
        ).isActive = true
        productPriceLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 10
        ).isActive = true
        productPriceLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: 10
        ).isActive = true
        productPriceLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor, constant: -10
        ).isActive = true
    }
}

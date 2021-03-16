//
//  ProductReviewTableViewCell.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 16.03.2021.
//

import UIKit

class ProductReviewTableViewCell: UITableViewCell {
    public var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()
    
    public var reviewTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white

        contentView.addSubview(userNameLabel)
        contentView.addSubview(reviewTextLabel)
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        setupProductNameLabelConstrains()
        setupProductPriceLabelConstrains()
    }

    private func setupProductNameLabelConstrains() {
        userNameLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor, constant: 10
        ).isActive = true
        userNameLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 10
        ).isActive = true
        userNameLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: 10
        ).isActive = true
    }
    
    private func setupProductPriceLabelConstrains() {
        reviewTextLabel.topAnchor.constraint(
            equalTo: userNameLabel.bottomAnchor, constant: 10
        ).isActive = true
        reviewTextLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 10
        ).isActive = true
        reviewTextLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: 10
        ).isActive = true
        reviewTextLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor, constant: -10
        ).isActive = true
    }
}

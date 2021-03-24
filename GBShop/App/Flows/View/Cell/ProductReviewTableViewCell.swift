//
//  ProductReviewTableViewCell.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 16.03.2021.
//

import UIKit

final class ProductReviewTableViewCell: UITableViewCell {
    
    private(set) lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()
    
    private(set) lazy var reviewTextLabel: UILabel = {
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
        setupReviewTextLabelConstrains()
    }
    
    private func setupProductNameLabelConstrains() {
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10)
        ])
    }
    
    private func setupReviewTextLabelConstrains() {
        NSLayoutConstraint.activate([
            reviewTextLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            reviewTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            reviewTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            reviewTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
    }
}

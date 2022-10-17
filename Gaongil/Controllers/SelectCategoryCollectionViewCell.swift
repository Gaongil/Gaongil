//
//  SelectCategoryCollectionViewCell.swift
//  Gaongil
//
//  Created by Lena on 2022/10/16.
//

import UIKit

class SelectCategoryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "SelectCategoryCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryLabel)

        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCellConstraints()
    }
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .customBlack
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func configureCellConstraints() {
        NSLayoutConstraint.activate([
           categoryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
           categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

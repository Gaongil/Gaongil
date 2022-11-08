//
//  CommitteeCustomCell.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/11/04.
//

import UIKit

class CommitteeCustomCell: UICollectionViewCell {
    
    static let collectaionCellId = "CommitteeCellId"
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        willSet {
            self.setSelected(newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(categoryLabel)
        
        configureCellConstraints()
        configureCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.setSelected(true)
    }
    
    private func setSelected(_ selected: Bool) {
        if selected {
            backgroundColor = .customSelectedGreen
            categoryLabel.textColor = .white
        } else {
            backgroundColor = .customUnselectedGreen
            categoryLabel.textColor = .customBlack
        }
    }
    
    private func configureCellConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configureCellUI() {
        self.layer.cornerRadius = 8
    }
}

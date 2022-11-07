//
//  TodayLawCollectionViewCell.swift
//  Gaongil
//
//  Created by Lena on 2022/11/03.
//

import UIKit

class TodayLawCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TodayLawCollectionViewCell"
    
    var progressBar: CircularProgressBarView = {
        let progressBar = CircularProgressBarView()
        progressBar.setProgress(progress: 0.4, color: .customSelectedGreen, percentage: "40%", progressStatus: "\n상임위원회 제출")
        progressBar.animate(0.4, duration: 2)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.font = .preferredFont(forTextStyle: .title3)
        label.text = "3차 병원에 대한 개정법률안"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var committeeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.text = "보건복지부"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textCellStackView: UIStackView = {
        let stackView = UIStackView()
        [titleLabel, committeeLabel].forEach {
             stackView.addArrangedSubview($0)
         }
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [textCellStackView, progressBar].forEach { contentView.addSubview($0) }
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCellConstraints()
    }
    
    private func configureCellConstraints() {
        NSLayoutConstraint.activate([
            textCellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenWidth / 50),
            textCellStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            progressBar.leadingAnchor.constraint(equalTo: textCellStackView.trailingAnchor, constant: screenWidth / 60),
            progressBar.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 6.6),
            progressBar.heightAnchor.constraint(equalToConstant: contentView.bounds.width / 6.6),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenWidth / 10),
            progressBar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}

//
//  TodayLawCollectionViewCell.swift
//  Gaongil
//
//  Created by Lena on 2022/11/03.
//

import UIKit

class TodayLawCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TodayLawCollectionViewCell"
    
    public lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.text = "원안가결"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    lazy var lightFlightStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [circleView, statusLabel])
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.spacing = 5
//        stackView.distribution = .equalCentering
//        stackView.backgroundColor = .white
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            circleView.widthAnchor.constraint(equalToConstant: 70),
//            circleView.heightAnchor.constraint(equalToConstant: 70)])
//
//        return stackView
//    }()
    

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
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
        [textCellStackView, circleView].forEach { contentView.addSubview($0) }
        circleView.addSubview(statusLabel)
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
            
            statusLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            circleView.leadingAnchor.constraint(equalTo: self.textCellStackView.trailingAnchor, constant: screenWidth / 70),
            circleView.heightAnchor.constraint(equalToConstant: 70),
            circleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            circleView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
}

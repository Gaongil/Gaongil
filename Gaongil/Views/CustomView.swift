//
//  View_Extensions.swift
//  Gaongil
//
//  Created by Lena on 2022/10/18.
//

import UIKit

class CustomView: UIView {
    
    let subTitleLabel = UILabel()
    let contentLabel = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureLabelConstraints()
    }
    
    func updateSubTitleLabel(_ text: String?) {
        guard let text = text else { return }
        subTitleLabel.text = text
    }
    
    func updateContentLabel(_ text: String?) {
        guard let text = text else { return }
        contentLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabelConstraints() {
        backgroundColor = .white
        
        subTitleLabel.textColor = .customBlack
        subTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        contentLabel.textColor = .customBlack
        contentLabel.font = .systemFont(ofSize: 18, weight: .regular)
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subTitleLabel)
        addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            subTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            subTitleLabel.widthAnchor.constraint(equalToConstant: screenWidth / 3.45),
            subTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: screenWidth / 15.6),
            subTitleLabel.heightAnchor.constraint(equalToConstant: screenHeight / 38.36),
            
            contentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: subTitleLabel.trailingAnchor),
            contentLabel.widthAnchor.constraint(equalToConstant: screenWidth / 1.82),
            contentLabel.heightAnchor.constraint(equalToConstant: screenHeight / 38.36),

        ])
    }
}


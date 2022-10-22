//
//  SettingsViewController.swift
//  Gaongil
//
//  Created by Seik Oh on 20/10/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "설정"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        [titleLabel, settingsTableView].forEach { view.addSubview($0)}
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight / 10.64),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 18.57),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth / 18.57),
        ])
    }

}

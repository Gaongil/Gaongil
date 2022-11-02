//
//  DeveloperPageViewController.swift
//  Gaongil
//
//  Created by Seik Oh on 02/11/2022.
//

import UIKit

class DeveloperPageViewController: UIViewController {

    //MARK: Properties
    private var largeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.text = "개발자"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var appVersionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "앱버전"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var appVersionNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.text = "1.0.0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var developerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Gaongil 개발팀"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var developerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "석혜민    박준혁    오세익"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [largeTitleLabel,
         appVersionTitleLabel,
         appVersionNumberLabel,
         developerTitleLabel,
         developerNameLabel].forEach { view.addSubview($0) }
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            largeTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight / 10.64),
            largeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 18.57),
            largeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth / 18.57),
            
            appVersionTitleLabel.topAnchor.constraint(equalTo: largeTitleLabel.bottomAnchor, constant: screenHeight / 30.54),
            appVersionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 18.57),
            appVersionTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth / 18.57),
            appVersionNumberLabel.topAnchor.constraint(equalTo: largeTitleLabel.bottomAnchor, constant: screenHeight / 30.54),
            appVersionNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth / 18.57),
            developerTitleLabel.topAnchor.constraint(equalTo: lineViewOne.bottomAnchor, constant: screenHeight / 30.54 * 2),
            developerTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 18.57),
            developerTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth / 18.57),
            developerNameLabel.topAnchor.constraint(equalTo: developerTitleLabel.bottomAnchor, constant: 12),
            developerNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 18.57),
            
        ])
    }
}

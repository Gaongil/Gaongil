//
//  FavoriteViewController.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/10/22.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let categoryCollectionView = TodayLawViewController().categoryCollectionView
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "관심 법안"
        
        view.addSubview(categoryCollectionView)
        
        configureConstraints()
    }
    
    // MARK: - Lifecycle
    
    private func configureConstraints() {
        
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: screenHeight / 15)
        ])
    }
    
    // MARK: - Helpers & fuction
    
}

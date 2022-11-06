//
//  FavoriteViewController.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/10/22.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Properties
    
    let committeeListView = CommitteeListView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "관심 법안"
        
        view.addSubview(committeeListView)
        
        configureConstraints()
    }
    
    // MARK: - Lifecycle
    
    private func configureConstraints() {
        
        committeeListView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            committeeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            committeeListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            committeeListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            committeeListView.heightAnchor.constraint(equalToConstant: screenHeight / 15)
        ])
    }
    
    // MARK: - Helpers & fuction
    
}

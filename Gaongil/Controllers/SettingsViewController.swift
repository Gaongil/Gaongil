//
//  SettingViewController.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/10/22.
//

import UIKit

class SettingsViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "설정"
        
        configureConstraints()
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
}

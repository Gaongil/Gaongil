//
//  MainTabBarController.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/10/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        
        // tabbar 가 선택 되었을 때 색을 지정
        self.tabBar.tintColor = .black
        
    }
    
    func configureViewControllers() {
        let law = TodayLawViewController()
        let lawNavigation = templateNavigationController(image: UIImage(systemName: "book.closed"), title: "오늘의 법안", rootViewController: law)
        
        let favorite = FavoriteViewController()
        let favoriteNavigation = templateNavigationController(image: UIImage(systemName: "star"), title: "관심 법안", rootViewController: favorite)
        
        let setting = SettingsViewController()
        let settingNavigation = templateNavigationController(image: UIImage(systemName: "person.crop.circle"), title: "MY", rootViewController: setting)
        
        viewControllers = [lawNavigation, favoriteNavigation, settingNavigation]
        
    }
    
    func templateNavigationController(image: UIImage?, title: String, rootViewController: UIViewController) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
        
    }
}

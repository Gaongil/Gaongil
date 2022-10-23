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
        let nav1 = templateNavigationController(image: UIImage(systemName: "book.closed"), title: "오늘의 법안", rootViewController: law)
        
        let favorite = FavoriteViewController()
        let nav2 = templateNavigationController(image: UIImage(systemName: "star"), title: "관심 법안", rootViewController: favorite)
        
        let setting = SettingsViewController()
        let nav3 = templateNavigationController(image: UIImage(systemName: "person.crop.circle"), title: "MY", rootViewController: setting)
        
        viewControllers = [nav1, nav2, nav3]
        
    }
    
    func templateNavigationController(image: UIImage?, title: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        nav.navigationBar.prefersLargeTitles = true
        
        return nav
        
    }
}

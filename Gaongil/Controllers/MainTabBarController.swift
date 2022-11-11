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
        self.tabBar.backgroundColor = .customLightGray
        
    }
    
    /// 분야 설정 후 Feed 화면으로 넘어갔을때 뒤로가기 Bar 없애기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func configureViewControllers() {
        let law = TodayLawViewController()
        let lawNavigation = templateNavigationController(image: UIImage(systemName: "book"), title: "오늘의 법안", rootViewController: law)
        
        let favorite = FavoriteViewController()
        let favoriteNavigation = templateNavigationController(image: UIImage(systemName: "star"), title: "관심 법안", rootViewController: favorite)
        
        let setting = SettingsViewController()
        let settingNavigation = templateNavigationController(image: UIImage(systemName: "gearshape"), title: "설정", rootViewController: setting)
        
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

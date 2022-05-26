//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Timur on 10.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    let feedVC = FeedViewController()
    let logInVC = LogInViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        feedVC.tabBarItem.title = "Новости"
        feedVC.tabBarItem.image = UIImage(systemName: "text.justify")
        let feedNav = UINavigationController(rootViewController: feedVC)
        
        logInVC.tabBarItem.title = "Профиль"
        logInVC.tabBarItem.image = UIImage(systemName: "person.fill")
        let profileNav = UINavigationController(rootViewController: logInVC)
        
        viewControllers = [feedNav, profileNav]
    }
}

//
//  TabBarController.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 25/05/2021.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        homeViewController.tabBarItem.title = "Home"
        homeViewController.tabBarItem.image = UIImage(systemName: "homekit")
        
        let favouritesViewController = UINavigationController(rootViewController: FavouritesViewController())
        favouritesViewController.tabBarItem.title = "Favourite"
        favouritesViewController.tabBarItem.image = UIImage(systemName: "bookmark")
        viewControllers = [homeViewController, favouritesViewController ]
    }
}

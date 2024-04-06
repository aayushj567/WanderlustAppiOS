//
//  ViewController.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 3/22/24.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: setting up home tab bar...
        let homeTab = UINavigationController(rootViewController: HomeViewController())
        let homeTabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "house.fill")
        )
        homeTab.tabBarItem = homeTabBarItem
        homeTab.title = "Home"
        
        //MARK: setting up Chats tab bar...
        let chatsTab = UINavigationController(rootViewController: ChatsViewController())
        let chatsTabBarItem = UITabBarItem(
            title: "Chats",
            image: UIImage(systemName: "text.bubble")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "text.bubble.fill")
        )
        chatsTab.tabBarItem = chatsTabBarItem
        chatsTab.title = "Chats"
        
        //MARK: setting up Profile tab bar...
        let profileTab = UINavigationController(rootViewController: ProfileViewController())
        let profileTabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.crop.circle")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "person.crop.circle.fill")
        )
        profileTab.tabBarItem = profileTabBarItem
        profileTab.title = "Profile"
        
        //MARK: setting up this view controller as the Tab Bar Controller...
        self.viewControllers = [homeTab, chatsTab, profileTab]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

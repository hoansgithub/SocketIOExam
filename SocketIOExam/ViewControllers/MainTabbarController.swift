//
//  MainTabbarController.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/29/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsViewController(collectionViewLayout: layout)
        let recentMessagesNav = UINavigationController(rootViewController: friendsController);
        recentMessagesNav.tabBarItem.title = "Recent"
        recentMessagesNav.tabBarItem.image = UIImage(named: "recent")
        
        
        let callsController = UIViewController()
        let callsNav = UINavigationController(rootViewController: callsController)
        callsNav.tabBarItem.title = "Calls"
        callsNav.tabBarItem.image = UIImage(named: "calls")
        
        let groupsController = UIViewController()
        let groupsNav = UINavigationController(rootViewController: groupsController)
        groupsNav.tabBarItem.title = "Groups"
        groupsNav.tabBarItem.image = UIImage(named: "groups")
        
        let peopleController = UIViewController()
        let peopleNav = UINavigationController(rootViewController: peopleController)
        peopleNav.tabBarItem.title = "People"
        peopleNav.tabBarItem.image = UIImage(named: "people")
        
        let settingsController = UIViewController()
        let settingsNav = UINavigationController(rootViewController: settingsController)
        settingsNav.tabBarItem.title = "Settings"
        settingsNav.tabBarItem.image = UIImage(named: "settings")
        
        viewControllers = [recentMessagesNav, callsNav, groupsNav, peopleNav, settingsNav]
    }

}

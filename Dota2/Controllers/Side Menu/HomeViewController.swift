//
//  HomeViewController.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

class HomeViewController: SideMenuController {
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigateTo(viewController: DashboardViewController.self, segueType: .sideMenuContent)
        
        navigateTo(viewController: SideMenuViewController.self, segueType: .sideMenu)
    }
    
}


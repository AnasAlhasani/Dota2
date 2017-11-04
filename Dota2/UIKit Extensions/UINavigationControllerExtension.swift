//
//  UINavigationControllerExtension.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func addSideMenuButton() {
        
        guard let sideMenuController = sideMenuController else { return }
        
        let image = UIImage(named: "Menu")
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setImage(image, for: .normal)
        button.addTarget(sideMenuController, action: #selector(SideMenuController.toggle), for: .touchUpInside)
        
        let menuItem  = UIBarButtonItem(customView: button)
        topViewController?.navigationItem.leftBarButtonItem = menuItem
    }
    
}


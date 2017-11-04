//
//  UIViewControllerExtension.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

enum SegueType {
    case present
    case push
    case presentNavigationBar
    case sideMenuContent
    case sideMenu
}

extension UIViewController: StoryboardIdentifiable {
    
    static func instantiateViewController() -> Self {
        return UIStoryboard(storyboard: .main).instantiateViewController()
    }
    
    func navigateTo(viewController controller: UIViewController.Type, segueType segue: SegueType) {
        
        let controller = controller.instantiateViewController()
        
        switch segue {
        case .push:
            navigationController?.pushViewController(controller, animated: true)
        case .present:
            present(controller, animated: true, completion: nil)
        case .presentNavigationBar:
            let navigationController = UINavigationController(rootViewController: controller)
            present(navigationController, animated: true, completion: nil)
        case .sideMenuContent:
            let navigationController = UINavigationController(rootViewController: controller)
            sideMenuController?.embed(centerViewController: navigationController)
        case .sideMenu:
            sideMenuController?.embed(sideViewController: controller)
        }
        
    }
    
    
    var sideMenuController: SideMenuController? {
        return getSideMenuController(self)
    }
    
    private func getSideMenuController(_ controller : UIViewController) -> SideMenuController? {
        
        if let sideController = controller as? SideMenuController {
            return sideController
        }
        
        guard let parent = controller.parent else { return nil }
        
        return getSideMenuController(parent)
        
    }
    
}


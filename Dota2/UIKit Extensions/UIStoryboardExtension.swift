//
//  UIStoryboardExtension.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    
    static var storyboardIdentifier: String { get }
    
}

extension StoryboardIdentifiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
}

extension UIStoryboard {
    
    enum Storyboard: String {
        case main
        
        var fileName: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(storyboard: Storyboard) {
        self.init(name: storyboard.fileName, bundle: nil)
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        
        guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier)")
        }
        return viewController
    }
    
    
}


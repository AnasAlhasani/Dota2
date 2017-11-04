//
//  UIViewExtension.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

extension UIView {
    
    class func panelAnimation(
        _ duration : TimeInterval,
        animations : @escaping (()->()),
        completion : (()->())? = nil) {
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: animations) { _ in
            completion?()
        }
    }
}

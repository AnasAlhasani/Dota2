//
//  SideMenuCell.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    @IBOutlet private weak var serviceLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    
    var serviceTitle: String? {
        didSet{
            if let serviceTitle = serviceTitle {
                serviceLabel.text = serviceTitle
            }
        }
    }
    
    var imageName: String? {
        didSet{
            if let imageName = imageName {
                iconImageView.image = UIImage(named: imageName)
            }
        }
    }
    
}

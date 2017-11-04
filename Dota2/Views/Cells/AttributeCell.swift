//
//  AttributeCell.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

class AttributeCell: UICollectionViewCell {
    
    @IBOutlet private weak var attributeImageView: UIImageView!
    @IBOutlet private weak var attributeTitleLabel: UILabel!
    
    var attribute: (image: UIImage, name: String)? {
        didSet{
            if let attribute = attribute {
                attributeImageView.image = attribute.image
                attributeTitleLabel.text = attribute.name
            }
        }
    }
}

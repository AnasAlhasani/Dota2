//
//  HeroCell.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

class HeroCell: UICollectionViewCell {
    
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var heroNameLabel: UILabel!
    
    var hero: Hero? {
        didSet{
            if let hero = hero {
                heroImageView.image = hero.image
                heroNameLabel.text = hero.name
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = frame.size.width * 0.125
        layer.borderWidth = 2
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImageView.image = nil
        heroNameLabel.text = ""
    }
}

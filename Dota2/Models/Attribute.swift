//
//  Attribute.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

struct Attribute {
    
    let image: UIImage
    let name: String
    
    static func allAttributes() -> [Attribute] {
        var attributes: [Attribute] = []
        
        let strength = Attribute(image: #imageLiteral(resourceName: "Strength"), name: "Strength")
        attributes.append(strength)
        
        let agility = Attribute(image: #imageLiteral(resourceName: "Agility"), name: "Agility")
        attributes.append(agility)
        
        let intelligence = Attribute(image: #imageLiteral(resourceName: "Intelligence"), name: "Intelligence")
        attributes.append(intelligence)
        
        return attributes
    }
    
}


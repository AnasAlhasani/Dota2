//
//  Attribute.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

enum Attribute: String {
    
    case strength = "Strength"
    case agility = "Agility"
    case intelligence = "Intelligence"
    
    static let allTypes: [Attribute] = [.strength, .agility, .intelligence]
    
    static func loadAttributes() -> [(image: UIImage, name: String)] {
        
        var attributes: [(image: UIImage, name: String)] = []

        attributes.append((image: #imageLiteral(resourceName: "Strength"), name: Attribute.strength.rawValue))
        attributes.append((image: #imageLiteral(resourceName: "Agility"), name: Attribute.agility.rawValue))
        attributes.append((image: #imageLiteral(resourceName: "Intelligence"), name: Attribute.intelligence.rawValue))
        
        return attributes
    }
    
}


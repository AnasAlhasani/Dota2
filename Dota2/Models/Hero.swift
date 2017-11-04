//
//  Hero.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

struct Hero {
    
    var image: UIImage
    var name: String
    
    private init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
    
    private init?(dictionary: [String: String]) {
        guard let name = dictionary["Name"],
            let imageName = dictionary["Image"],
            let image = UIImage(named: imageName) else {
                return nil
        }
        self.init(image: image, name: name)
    }
    
    static func allHeroes() -> [Hero] {
        var heroes = [Hero]()
        guard let URL = Bundle.main.url(forResource: "Heroes", withExtension: "plist"),
            let heroesFromPlist = NSArray(contentsOf: URL) as? [[String:String]] else {
                return heroes
        }
        for dictionary in heroesFromPlist {
            if let hero = Hero(dictionary: dictionary) {
                heroes.append(hero)
            }
        }
        return heroes
    }
}


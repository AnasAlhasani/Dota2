//
//  StretchyHeaderLayout.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes = super.layoutAttributesForElements(in: rect)! as [UICollectionViewLayoutAttributes]
        
        let offset = collectionView!.contentOffset
        
        guard offset.y < 0 else { return layoutAttributes }
        
        let deltaY = fabs(offset.y)
        
        for attributes in layoutAttributes {
            
            guard let elementKind = attributes.representedElementKind else { continue }
            guard elementKind == UICollectionElementKindSectionHeader else { continue }
            var frame = attributes.frame
            frame.size.height = max(0, headerReferenceSize.height + deltaY)
            frame.origin.y = frame.minY - deltaY
            attributes.frame = frame
        }
        
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}



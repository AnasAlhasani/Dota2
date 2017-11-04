//
//  HeroesViewController.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

class HeroesViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: Properties
    private let attributes = Attribute.allAttributes()
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Heroes"
        setupFlowLayout()
    }
    
}

//MARK: - Helper Methods
private extension HeroesViewController {
    
    func setupFlowLayout() {
        let width = collectionView!.bounds.width - 4.0
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 62)
        layout.minimumLineSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
    }
}

//MARK: - UICollectionViewDataSource
extension HeroesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attributes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttributeCell", for: indexPath) as! AttributeCell
        let attribute = attributes[indexPath.item]
        cell.attribute = attribute
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeroHeaderView", for: indexPath) as! HeroHeaderView
        return header
    }
}

//MARK: - UICollectionViewDelegate
extension HeroesViewController: UICollectionViewDelegate {
    
    //FIXME: To be removed later
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let controller = HeroesDetailsViewController.instantiateViewController()
        let attribute = attributes[indexPath.item]
        controller.attributeString = attribute.name
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

//
//  HeroesDetailsViewController.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

class HeroesDetailsViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: Properties
    var heroes: [Hero] = []
    var attributeString: String!
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = attributeString + " Heroes"
        addBackButton()
        setupRefreshControl()
        setupFlowLayout()
    }
    
    //MARK: Actions
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshControlDidFire() {
        collectionView?.reloadData()
        collectionView?.refreshControl?.endRefreshing()
    }
    
}

//MARK: - Helper Methods
private extension HeroesDetailsViewController {
    
    func addBackButton() {
        let image = UIImage(named: "BackItem")
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backItem = UIBarButtonItem(customView: button)
        navigationController?.topViewController?.navigationItem.leftBarButtonItem = backItem
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlDidFire), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }
    
    func setupFlowLayout() {
        let layout = collectionView.collectionViewLayout as! HeroFlowLayout
        
        layout.estimatedItemSize = CGSize(width: 200.0 * layout.standardItemScale,
                                          height: 200.0 * layout.standardItemScale)
        
        layout.minimumLineSpacing = -(layout.itemSize.height * 0.5)
    }
}


//MARK: - UICollectionViewDataSource
extension HeroesDetailsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as! HeroCell
        
        cell.hero = heroes[indexPath.item]
        return cell
    }
}


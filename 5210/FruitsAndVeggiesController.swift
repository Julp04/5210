//
//  FruitsAndVeggiesController.swift
//  5210
//
//  Created by Panucci, Julian R on 4/2/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import UIKit

class FruitsAndVeggiesController: UIViewController {
    
    //MARK: Constants
    
    //MARK: Properties
    
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    
    fileprivate let itemsPerRow: CGFloat = 2

    
    //MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK: Actions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

}

extension FruitsAndVeggiesController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
}

extension FruitsAndVeggiesController: UICollectionViewDelegate {
    
    
    
}

extension FruitsAndVeggiesController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath)
        cell.backgroundColor = .red
        
        return cell
    }
}

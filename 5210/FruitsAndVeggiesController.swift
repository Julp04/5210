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
    
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 0 , bottom: 0, right: 0)
    
    fileprivate let itemsPerRow: CGFloat = 3
    var food = Food()
    
    var fruits = [FoodView]()
    var veggies = [FoodView]()

    
    //MARK: Outlets
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK: Actions

    @IBAction func segmentControlSwitch(_ sender: Any) {
        collectionView.reloadData()
    }
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
        let paddingSpace: CGFloat = 0.0
        let availableWidth = collectionView.frame.width
        let widthPerItem = availableWidth / 2
        
        print(widthPerItem)
        return CGSize(width: 184, height: 140)
    }
    
    //3
   
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    
}

extension FruitsAndVeggiesController: UICollectionViewDelegate {
    
    
    
}

extension FruitsAndVeggiesController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return food.numberOfFruits()
        case 1:
            return food.numberOfVegetables()
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath)
        cell.backgroundColor = .red
        
        var foodView: FoodView!
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            foodView = food.fruits[indexPath.row]
        case 1:
            foodView = food.veggies[indexPath.row]
        default:
            break
        }
        


        cell.addSubview(foodView)
        
        return cell
    }
}

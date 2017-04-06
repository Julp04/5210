//
//  FruitsAndVeggiesController.swift
//  5210
//
//  Created by Panucci, Julian R on 4/2/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import UIKit


public enum TrackingType {
    case FruitsAndVeggies
    case ScreenTime
    case Drinks
    case Activity
}


class FruitsAndVeggiesController: UIViewController {
    
    //MARK: Constants
    
    //MARK: Properties
    
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 0 , bottom: 0, right: 0)
    
    fileprivate let itemsPerRow: CGFloat = 3
    
    var foodModel: FoodModel!
    
    var foodView: FoodView!
    weak var delegate: ServingsDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    var type: TrackingType = .FruitsAndVeggies
    
    @IBOutlet weak var titleImageView: UIImageView!

    
    //MARK: Outlets
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberOfServingsLabel: UILabel!
    //MARK: Actions


    @IBAction func enterAction(_ sender: Any) {
        enter()
    }
    @IBAction func segmentControlSwitch(_ sender: Any) {
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        delegate = self
        
        
        switch self.type {
        case .FruitsAndVeggies:
            self.segmentControl.isHidden = false
            titleLabel.text = "Number of servings:"
            titleImageView.image = #imageLiteral(resourceName: "fruits_veggies_icon")
        case .ScreenTime:
            self.segmentControl.isHidden = true
            titleLabel.text = "Screen time hours:"
            titleImageView.image = #imageLiteral(resourceName: "screen_time_icon")
        case .Activity:
            self.segmentControl.isHidden = true
            titleLabel.text = "Activity hours:"
            titleImageView.image = #imageLiteral(resourceName: "activity_icon")
        case .Drinks:
            titleLabel.text = "Number of sugary drinks:"
            self.segmentControl.isHidden = false
            titleImageView.image = #imageLiteral(resourceName: "drinks_icon")
        }
      
        foodModel = FoodModel(forType: self.type)
    
    }
    
    func configureViewController(type: TrackingType) {
        self.type = type
    }
    
    func enter() {
        //Get totals, populate database, and pop the controller back
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Segue")
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
        
        
        switch self.type {
        case .FruitsAndVeggies:
            switch segmentControl.selectedSegmentIndex {
            case 0:
                return foodModel.numberOfFruits()
            case 1:
                return foodModel.numberOfVegetables()
            default:
                return 0
            }
        case .ScreenTime:
            return foodModel.numberOfFruits()
            
        case .Activity: break
        case .Drinks: break
        }
        return foodModel.numberOfFruits()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath)
        cell.backgroundColor = .red
        
        
        switch self.type {
        case .FruitsAndVeggies:
            switch segmentControl.selectedSegmentIndex {
            case 0:
                foodView = foodModel.fruitsView[indexPath.row]
            case 1:
                foodView = foodModel.veggiesView[indexPath.row]
            default:
                break
            }
        default:
            foodView = foodModel.fruitsView[indexPath.row]
        }
        
    
        
        foodView.delegate = self
        
        cell.addSubview(foodView)
        
        return cell
    }
}


extension FruitsAndVeggiesController: ServingsDelegate {
    
    func countChanged() {
        self.numberOfServingsLabel.text = String(foodModel.totalNumberOfServings())
    }
}



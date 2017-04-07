//
//  FruitsAndVeggiesController.swift
//  5210
//
//  Created by Panucci, Julian R on 4/2/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase


public enum TrackingType: String {
    case FruitsAndVeggies = "five"
    case ScreenTime = "two"
    case Drinks = "zero"
    case Activity = "one"
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
        updateWaterCount()
        
        switch type {
        case .Drinks:
        
            if segmentControl.selectedSegmentIndex == 0 {
                self.titleLabel.text = "Number of Sugary Drinks"
            }else {
                self.titleLabel.text = "Cups of Water"
            }
        default:
            break
        }
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
            self.segmentControl.setTitle("Fruits", forSegmentAt: 0)
            self.segmentControl.setTitle("Veggies:", forSegmentAt: 1)
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
            self.segmentControl.setTitle("Sugary Drinks", forSegmentAt: 0)
            self.segmentControl.setTitle("Water", forSegmentAt: 1)
            titleImageView.image = #imageLiteral(resourceName: "drinks_icon")
        }
      
        foodModel = FoodModel(forType: self.type)
    
    }
    
    func configureViewController(type: TrackingType) {
        self.type = type
    }
    
    func enter() {
        //Get totals, populate database, and pop the controller back
        
        
        let date = Date()
        let calendar = Calendar.current
        let compononents = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year = compononents.year!
        let month = compononents.month!
        let day = compononents.day!
        
        let dateString = "\(month)\(day)\(year)"
        
        
        var items =  [FoodView]()
        
        switch self.type {
        case .FruitsAndVeggies, .Drinks:
            for view in foodModel.fruitsView {
                items.append(view)
            }
            
            for view in foodModel.veggiesView {
                items.append(view)
            }
            
        case .ScreenTime, .Activity:
            for view in foodModel.fruitsView {
                items.append(view)
            }
        }
        
        FireClient.saveCategory(date: dateString, type: self.type, items: items)
        
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
        case .FruitsAndVeggies, .Drinks:
            switch segmentControl.selectedSegmentIndex {
            case 0:
                return foodModel.numberOfFruits()
            case 1:
                return foodModel.numberOfVegetables()
            default:
                return 0
            }
        default:
            break
        }
        return foodModel.numberOfFruits()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath)
        cell.backgroundColor = .red
        
        
        switch self.type {
        case .FruitsAndVeggies, .Drinks:
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
    
    func updateWaterCount() {
        var total = 0.0
        if segmentControl.selectedSegmentIndex == 0  {
            
            for item in foodModel.fruitsView {
                total += item.count
            }
            
        }else {
            for item in foodModel.veggiesView {
                total += item.count
            }
        }
        self.numberOfServingsLabel.text = String(total)
    }
}


extension FruitsAndVeggiesController: ServingsDelegate {
    
    func countChanged() {
        
        switch type {
        case .Drinks:
            updateWaterCount()
        default:
            self.numberOfServingsLabel.text = String(foodModel.totalNumberOfServings())
        }
        
    }
}





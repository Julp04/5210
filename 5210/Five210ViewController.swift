//
//  Five210ViewController.swift
//  5210
//
//  Created by Panucci, Julian R on 4/2/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import UIKit
import Cosmos

class Five210ViewController: UIViewController {
    
    //MARK: Constants
    
    let kDirectionsBeforeText = "Enter today's 5-2-1-0 amounts below"
    
    
    //MARK: Properties
    
    //MARK: Outlets
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var fruitsImageView: UIImageView!
    @IBOutlet weak var screenTimeImageView: UIImageView!
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var drinksImageView: UIImageView!

    @IBOutlet weak var activityStarThree: CosmosView!
    @IBOutlet weak var activityStar2: CosmosView!

    @IBOutlet weak var fruitStarsThree: CosmosView!
    @IBOutlet weak var fruitStars2: CosmosView!
    
    @IBOutlet weak var screenStar: CosmosView!
    @IBOutlet weak var drinksStar: CosmosView!
    
    var fruitButton: UIButton!
    var screenButton: UIButton!
    var activityButton: UIButton!
    var drinksButton: UIButton!
    
    var allStars: [CosmosView]!
    
   

    
    @IBOutlet weak var imageStackView: UIStackView!
    //MARK: Actions
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allStars = [activityStarThree, activityStar2, fruitStars2, fruitStarsThree, drinksStar, screenStar]
        
        setupTabBar()
        setupImageViews()
        setupButtons()
    
        setupForBeforeEntering()
        setUpAfterEntering()
        
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        
    }
    
    //MARK: UI
    
    func setupForBeforeEntering() {
        
        let beforeFruits = #imageLiteral(resourceName: "before_fruits")
        let beforeScreenTime = #imageLiteral(resourceName: "before_screen_time")
        let beforeActivity = #imageLiteral(resourceName: "before_physical_activity")
        let beforeDrinks = #imageLiteral(resourceName: "before_sugary_drinks")
        
        fruitsImageView.image = beforeFruits
        screenTimeImageView.image = beforeScreenTime
        activityImageView.image = beforeActivity
        drinksImageView.image = beforeDrinks
        
        allStars.forEach { (starView) in
            starView.isHidden = true
        }
        
        directionsLabel.text = kDirectionsBeforeText
    }
    
    func setUpAfterEntering() {
        
        fruitsImageView.image = #imageLiteral(resourceName: "after_fruits")
        screenTimeImageView.image = #imageLiteral(resourceName: "after_screen")
        drinksImageView.image = #imageLiteral(resourceName: "after_drinks")
        activityImageView.image = #imageLiteral(resourceName: "after_activity")
        
        
        allStars.forEach { (starView) in
            starView.isHidden = false
        }
        
    }
    
    
    
    
    func setupImageViews() {
        
        let imageViewArray = [fruitsImageView, screenTimeImageView, activityImageView, drinksImageView]
        
        imageViewArray.forEach { (imageView) in
            let fadedGray = #colorLiteral(red: 0.5441386421, green: 0.5441386421, blue: 0.5441386421, alpha: 0.5).cgColor
    
            imageView?.layer.borderColor = fadedGray
            imageView?.layer.borderWidth = 0.5
        }
        
    }
    
    func setupButtons() {
        fruitButton = UIButton(frame: fruitsImageView.frame)
        fruitButton.addTarget(self, action: #selector(Five210ViewController.presentFruitsAndVeggies), for: .touchUpInside)
        
        
        screenButton = UIButton(frame: screenTimeImageView.frame)
        screenButton.addTarget(self, action: #selector(Five210ViewController.presentScreenTime), for: .touchUpInside)
        
        activityButton = UIButton(frame: activityImageView.frame)
        activityButton.addTarget(self, action: #selector(Five210ViewController.presentActivity), for: .touchUpInside)
        activityButton.frame.origin.y = activityButton.frame.origin.y + activityButton.frame.size.height
        
        
        drinksButton = UIButton(frame: drinksImageView.frame)
        drinksButton.addTarget(self, action: #selector(Five210ViewController.presentDrinks), for: .touchUpInside)
        drinksButton.frame.origin.y = drinksButton.frame.origin.y + drinksButton.frame.size.height
        
        let buttonsView = UIView(frame: imageStackView.frame)
        buttonsView.addSubview(fruitButton)
        buttonsView.addSubview(screenButton)
        buttonsView.addSubview(activityButton)
        buttonsView.addSubview(drinksButton)
        
        view.addSubview(buttonsView)
    }
    
    func setupTabBar() {
        let tabBarImageColor = #imageLiteral(resourceName: "ic_5210").withRenderingMode(.alwaysOriginal)
        let tabBarImageGray = #imageLiteral(resourceName: "ic_5210_gray").withRenderingMode(.alwaysOriginal)
        
        self.navigationController?.tabBarItem.selectedImage = tabBarImageColor
        self.navigationController?.tabBarItem.image = tabBarImageGray
        self.navigationController?.tabBarItem.title = "5210"
    }
    
    //MARK: Segue
    
    func presentFruitsAndVeggies() {
        print("Fruits and veggies")
        let fruitsAndVeggiesController = self.storyboard?.instantiateViewController(withIdentifier: "FruitsAndVeggiesController") as! FruitsAndVeggiesController
        navigationController?.pushViewController(fruitsAndVeggiesController, animated: true)
    }
    
    func presentScreenTime() {
        print("Screen time")
    }
    
    func presentActivity() {
        print("Activity")
    }
    
    func presentDrinks() {
        print("Drinks")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}

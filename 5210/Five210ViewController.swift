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
    
    @IBOutlet weak var activityStar1: CosmosView!

    @IBOutlet weak var fruitStarsThree: CosmosView!
    @IBOutlet weak var fruitStars2: CosmosView!
    
    @IBOutlet weak var screenStar: CosmosView!
    @IBOutlet weak var drinksStar: CosmosView!
    
    var fruitButton: UIButton!
    var screenButton: UIButton!
    var activityButton: UIButton!
    var drinksButton: UIButton!
    
    var allStars: [CosmosView]!
    
    var type: TrackingType!
    
   

    
    @IBOutlet weak var imageStackView: UIStackView!
    //MARK: Actions
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allStars = [activityStarThree, activityStar1, fruitStars2, fruitStarsThree, drinksStar, screenStar]
        
        setupTabBar()
        setupImageViews()
        setupButtons()
    
       
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        
        FireClient.currentUser { (user) in
            let name = user.name
            self.welcomeLabel.text = "Hi \(name!)!"
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkFruits()
        checkDrinks()
        checkActivity()
        checkScreenTime()
        
    }
    
    
    func checkFruits() {
        FireClient.checkForTodaysStats(forType: .FruitsAndVeggies) { (infoEntered) in
            if infoEntered {
                self.updateStarsForFruits()
                self.fruitsImageView.image = #imageLiteral(resourceName: "after_fruits")
            }else {
                //Hide stars and show other image
                self.fruitsImageView.image = #imageLiteral(resourceName: "before_fruits")
                self.fruitStars2.alpha = 0.0
                self.fruitStarsThree.alpha = 0.0
                
            }
        }
    }
    
    func updateStarsForFruits() {
        self.fruitStars2.alpha = 1.0
        self.fruitStarsThree.alpha = 1.0
        
        FireClient.getTotalForFruits { (total) in
            if total >= 3.0 {
                self.fruitStarsThree.rating = 3.0
                self.fruitStars2.rating = total - 3.0
            }else {
                self.fruitStarsThree.rating = total
                self.fruitStars2.rating = 0.0
            }
        }
    }
    
    func checkScreenTime() {
        FireClient.checkForTodaysStats(forType: .ScreenTime) { (infoEntered) in
            if infoEntered {
                self.updateStarsForScreenTime()
                self.screenTimeImageView.image = #imageLiteral(resourceName: "after_screen")
            }else {
                self.screenTimeImageView.image = #imageLiteral(resourceName: "before_screen_time")
                self.screenStar.alpha = 0.0
            }
        }
    }
    
    func updateStarsForScreenTime() {
        self.screenStar.alpha = 1.0
        
        FireClient.getTotalScreenTime { (total) in
            if total <= 2 {
                self.screenStar.rating = 1.0
            }else {
                self.screenStar.rating = 0.0
            }
        }
    }
    
    func checkActivity() {
        FireClient.checkForTodaysStats(forType: .Activity) { (infoEntered) in
            if infoEntered {
                self.updateStarsForActivity()
                self.activityImageView.image = #imageLiteral(resourceName: "after_activity")
            }else {
                self.activityImageView.image = #imageLiteral(resourceName: "before_physical_activity")
                self.activityStarThree.alpha = 0.0
                self.activityStar1.alpha = 0.0
        
            }
        }
    }
    
    func updateStarsForActivity() {
        activityStarThree.alpha = 1.0
        activityStar1.alpha = 1.0
        
        FireClient.getTotalForActivity { (total) in
            
            switch total {
            case 0.50:
                self.activityStarThree.rating = 1.0
                self.activityStar1.rating = 0.0
            case 0.51 ... 1.0:
                self.activityStarThree.rating = 2.0
                self.activityStar1.rating = 0.0
            case 1.1 ... 1.50:
                self.activityStarThree.rating = 3.0
                self.activityStar1.rating = 0.0
            case _ where total >= 1.51:
                self.activityStarThree.rating = 3.0
                self.activityStar1.rating = 1.0
            default:
                self.activityStar1.rating = 0.0
                self.activityStarThree.rating = 0.0
            }
            
        }
    }
    
    func checkDrinks() {
        FireClient.checkForTodaysStats(forType: .Drinks) { (infoEntered) in
            if infoEntered {
                self.updateStarsForDrinks()
                self.drinksImageView.image = #imageLiteral(resourceName: "after_drinks")
            }else {
                self.drinksImageView.image = #imageLiteral(resourceName: "before_sugary_drinks")
                self.drinksStar.alpha = 0.0
            }
        }
        
    }
    
    func updateStarsForDrinks() {
        self.drinksStar.alpha = 1.0
        
        FireClient.getDrinks { (water, sugarDrinks) in
            self.drinksStar.rating = 0.0
            var rating = 0.0
            
            if water >= 1 {
                rating += 1
            }
            
            if sugarDrinks == 0 {
                rating += 1
            }
            
            self.drinksStar.rating = rating
        }
        
    }
    //MARK: UI
    
    
    
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
        self.type = .FruitsAndVeggies
        print("Fruits and veggies")
        let fruitsAndVeggiesController = self.storyboard?.instantiateViewController(withIdentifier: "FruitsAndVeggiesController") as! FruitsAndVeggiesController
        fruitsAndVeggiesController.configureViewController(type: self.type)

        navigationController?.pushViewController(fruitsAndVeggiesController, animated: true)
    }
    
    func presentScreenTime() {
        self.type = .ScreenTime
        let fruitsAndVeggiesController = self.storyboard?.instantiateViewController(withIdentifier: "FruitsAndVeggiesController") as! FruitsAndVeggiesController
        fruitsAndVeggiesController.configureViewController(type: self.type)
        navigationController?.pushViewController(fruitsAndVeggiesController, animated: true)
        print("Screen time")
    }
    
    func presentActivity() {
        self.type = .Activity
        let fruitsAndVeggiesController = self.storyboard?.instantiateViewController(withIdentifier: "FruitsAndVeggiesController") as! FruitsAndVeggiesController
        fruitsAndVeggiesController.configureViewController(type: self.type)
        navigationController?.pushViewController(fruitsAndVeggiesController, animated: true)
        print("Activity")
    }
    
    func presentDrinks() {
        self.type = .Drinks
        let fruitsAndVeggiesController = self.storyboard?.instantiateViewController(withIdentifier: "FruitsAndVeggiesController") as! FruitsAndVeggiesController
        fruitsAndVeggiesController.configureViewController(type: self.type)
        navigationController?.pushViewController(fruitsAndVeggiesController, animated: true)
        print("Drinks")
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}

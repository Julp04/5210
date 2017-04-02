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
    
    
    //MARK: Properties
    
    //MARK: Outlets
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var fiveImageView: UIImageView!
    @IBOutlet weak var twoImageView: UIImageView!
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var zeroImageView: UIImageView!
    
    @IBOutlet weak var twoStarView: CosmosView!
    @IBOutlet weak var zeroStarView: CosmosView!
   
    @IBOutlet weak var fiveStarViewTHREE: CosmosView!
    @IBOutlet weak var fiveStarViewTWO: CosmosView!
    
    @IBOutlet weak var oneStarViewTHREE: CosmosView!
    @IBOutlet weak var oneStarViewTWO: CosmosView!
    
    var fiveButton: UIButton!
    var twoButton: UIButton!
    var oneButton: UIButton!
    var zeroButton: UIButton!
    
    @IBOutlet weak var imageStackView: UIStackView!
    //MARK: Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupImageViews()
        setupButtons()
    }
    
    
    //MARK: UI
    
    func setupImageViews() {
        
        let imageViewArray = [fiveImageView, twoImageView, oneImageView, zeroImageView]
        
        imageViewArray.forEach { (imageView) in
            let fadedGray = #colorLiteral(red: 0.5441386421, green: 0.5441386421, blue: 0.5441386421, alpha: 0.5).cgColor
    
            imageView?.layer.borderColor = fadedGray
            imageView?.layer.borderWidth = 0.5
        }
        
    }
    
    func setupButtons() {
        fiveButton = UIButton(frame: fiveImageView.frame)
        fiveButton.addTarget(self, action: #selector(Five210ViewController.presentFruitsAndVeggies), for: .touchUpInside)
        
        
        twoButton = UIButton(frame: twoImageView.frame)
        twoButton.addTarget(self, action: #selector(Five210ViewController.presentScreenTime), for: .touchUpInside)
        
        oneButton = UIButton(frame: oneImageView.frame)
        oneButton.addTarget(self, action: #selector(Five210ViewController.presentActivity), for: .touchUpInside)
        oneButton.frame.origin.y = oneButton.frame.origin.y + oneButton.frame.size.height
        
        
        zeroButton = UIButton(frame: zeroImageView.frame)
        zeroButton.addTarget(self, action: #selector(Five210ViewController.presentDrinks), for: .touchUpInside)
        zeroButton.frame.origin.y = zeroButton.frame.origin.y + zeroButton.frame.size.height
        
        let buttonsView = UIView(frame: imageStackView.frame)
        buttonsView.addSubview(fiveButton)
        buttonsView.addSubview(twoButton)
        buttonsView.addSubview(oneButton)
        buttonsView.addSubview(zeroButton)
        
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
        let 
        navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
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

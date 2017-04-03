//
//  FoodModel.swift
//  5210
//
//  Created by Panucci, Julian R on 4/2/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import Foundation
import UIKit

class FoodModel{
    
    
    private var fruitImages = [#imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "banana"), #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "grapes"), #imageLiteral(resourceName: "kiwi"), #imageLiteral(resourceName: "peach"), #imageLiteral(resourceName: "watermelon"), #imageLiteral(resourceName: "blueberries"),#imageLiteral(resourceName: "avocado"), #imageLiteral(resourceName: "pineapple"), #imageLiteral(resourceName: "plum"), #imageLiteral(resourceName: "Pear"), #imageLiteral(resourceName: "mango"), #imageLiteral(resourceName: "strawberry"), #imageLiteral(resourceName: "blackberries"), #imageLiteral(resourceName: "cranberries")]
    
    private var fruitNames = ["Apple", "Banana", "Orange", "Grapes", "Kiwi", "Peach", "Watermelon", "Blueberries", "Avocado", "Pineapple", "Plum", "Pear", "Mango", "Strawberry", "Blackberries", "Cranberries"]
    
    private var veggieImages = [#imageLiteral(resourceName: "leafy greens"), #imageLiteral(resourceName: "artichoke"), #imageLiteral(resourceName: "asparagus"), #imageLiteral(resourceName: "mushroom"), #imageLiteral(resourceName: "beet"), #imageLiteral(resourceName: "broccoli"), #imageLiteral(resourceName: "butternut squash"), #imageLiteral(resourceName: "cabbage"), #imageLiteral(resourceName: "lettuce"), #imageLiteral(resourceName: "peas"), #imageLiteral(resourceName: "snap peas"), #imageLiteral(resourceName: "onion"), #imageLiteral(resourceName: "peppers"), #imageLiteral(resourceName: "cauliflower"), #imageLiteral(resourceName: "corn"), #imageLiteral(resourceName: "carrot"), #imageLiteral(resourceName: "spinach"), #imageLiteral(resourceName: "tomato"), #imageLiteral(resourceName: "potato"), #imageLiteral(resourceName: "zuccini"), #imageLiteral(resourceName: "cucumber")]
    
    
    private var veggieNames = ["Leafy Greens", "Artichoke", "Asparagus", "Mushroom", "Beet", "Broccoli", "Butternut Squash","Cabbage", "Lettuce", "Peas", "Snap Peas", "Onion", "Peppers", "Cauliflower", "Corn", "Carrot", "Spinach", "Tomato", "Potato", "Zucchini", "Cucumber"]
    
    
    var fruitsView = [FoodView]()
    var veggiesView = [FoodView]()
    
    
    
    func numberOfFruits() -> Int {
        return fruitNames.count
    }
    
    func numberOfVegetables() -> Int {
        return veggieNames.count
    }
    
    func nameOfFruitAt(indexPath: IndexPath)  -> String{
        return fruitsView[indexPath.row].food.name
    }
    
    func nameOfVeggieAt(indexPath: IndexPath) -> String {
        return veggiesView[indexPath.row].food.name
    }
    
    func imageOfFruitAt(indexPath: IndexPath) -> UIImage {
        return fruitsView[indexPath.row].food.image
    }
    
    func imageOfVeggieAt(indexPath: IndexPath) -> UIImage {
        return veggiesView[indexPath.row].food.image
    }
    
    func totalNumberOfServings() -> Int {
            var totalServings: Int = 0
            
        for view in veggiesView {
            totalServings += view.food.numberOfServings
        }
            
        for view in fruitsView {
            totalServings += view.food.numberOfServings
        }
            
        return totalServings
    }
    
    init() {
        for i in 0 ..< fruitNames.count {
            let image = fruitImages[i]
            let name = fruitNames[i]
            
            let fruit = Food(name: name, image: image)
  
            let foodView = FoodView(frame: CGRect(x: 0.0, y: 0.0, width: 184.0, height: 140.0), food: fruit)
            
             fruitsView.append(foodView)
        }
        
        
        for i in 0 ..< veggieNames.count {
            let image = veggieImages[i]
            let name = veggieNames[i]
            
            let veggie = Food(name: name, image: image)
            

            let foodView = FoodView(frame: CGRect(x: 0.0, y: 0.0, width: 184.0, height: 140.0), food: veggie)
            
            veggiesView.append(foodView)
            }
    }
}

class Food {
    
    var name: String
    var image: UIImage
    
    var numberOfServings: Int = 0
    
    init(name: String, image: UIImage) {
        self.image = image
        self.name = name
    }
    
    
}





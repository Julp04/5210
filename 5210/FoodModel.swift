//
//  FoodModel.swift
//  5210
//
//  Created by Panucci, Julian R on 4/2/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import Foundation
import UIKit

class Food {
    
    
    private var fruitImages = [#imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "banana"), #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "grapes"), #imageLiteral(resourceName: "kiwi"), #imageLiteral(resourceName: "peach"), #imageLiteral(resourceName: "watermelon"), #imageLiteral(resourceName: "blueberries"),#imageLiteral(resourceName: "avocado"), #imageLiteral(resourceName: "pineapple"), #imageLiteral(resourceName: "plum"), #imageLiteral(resourceName: "Pear"), #imageLiteral(resourceName: "mango"), #imageLiteral(resourceName: "strawberry"), #imageLiteral(resourceName: "blackberries"), #imageLiteral(resourceName: "cranberries")]
    
    private var fruitNames = ["Apple", "Banana", "Orange", "Grapes", "Kiwi", "Peach", "Watermelon", "Blueberries", "Avocado", "Pineapple", "Plum", "Pear", "Mango", "Strawberry", "Blackberries", "Cranberries"]
    
    private var veggieImages = [#imageLiteral(resourceName: "leafy greens"), #imageLiteral(resourceName: "artichoke"), #imageLiteral(resourceName: "asparagus"), #imageLiteral(resourceName: "mushroom"), #imageLiteral(resourceName: "beet"), #imageLiteral(resourceName: "broccoli"), #imageLiteral(resourceName: "butternut squash"), #imageLiteral(resourceName: "cabbage"), #imageLiteral(resourceName: "lettuce"), #imageLiteral(resourceName: "peas"), #imageLiteral(resourceName: "snap peas"), #imageLiteral(resourceName: "onion"), #imageLiteral(resourceName: "peppers"), #imageLiteral(resourceName: "cauliflower"), #imageLiteral(resourceName: "corn"), #imageLiteral(resourceName: "carrot"), #imageLiteral(resourceName: "spinach"), #imageLiteral(resourceName: "tomato"), #imageLiteral(resourceName: "potato"), #imageLiteral(resourceName: "zuccini"), #imageLiteral(resourceName: "cucumber")]
    
    
    private var veggieNames = ["Leafy Greens", "Artichoke", "Asparagues", "Mushroom", "Beet", "Broccoli", "Squash","Cabbage", "Lettuce", "Peas", "Snap Peas", "Onion", "Peppers", "Cauliflower", "Corn", "Carrot", "Spinnach", "Tomato", "Potato", "Zuccini", "Cucumber"]
    
    var veggies = [FoodView]()
    var fruits = [FoodView]()
    
    
    func numberOfFruits() -> Int {
        return fruitNames.count
    }
    
    func numberOfVegetables() -> Int {
        return veggieNames.count
    }
    
    func nameOfFruitAt(indexPath: IndexPath)  -> String{
        return fruits[indexPath.row].foodName!
    }
    
    func nameOfVeggieAt(indexPath: IndexPath) -> String {
        return veggies[indexPath.row].foodName!
    }
    
    func imageOfFruitAt(indexPath: IndexPath) -> UIImage {
        return fruits[indexPath.row].image!
    }
    
    func imageOfVeggieAt(indexPath: IndexPath) -> UIImage {
        return veggies[indexPath.row].image!
    }
    
    init() {
        for i in 0 ..< fruitNames.count {
            let image = fruitImages[i]
            let name = fruitNames[i]
            
            let foodView = FoodView(frame: CGRect(x: 0.0, y: 0.0, width: 184.0, height: 140.0), image: image, name: name)
            fruits.append(foodView)
        }
        
        for i in 0 ..< veggieNames.count {
            let image = veggieImages[i]
            let name = veggieNames[i]
            
            let foodView = FoodView(frame: CGRect(x: 0.0, y: 0.0, width: 184.0, height: 140.0), image: image, name: name)
            veggies.append(foodView)
            
        }
    }
    
    
    
    
    
    
    
    
}

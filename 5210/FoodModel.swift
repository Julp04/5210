//
//  FoodModel.swift
//  5210
//
//  Created by Panucci, Julian R on 4/2/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import Foundation
import UIKit

class FoodModel {
    
    
    private var fruitImages = [#imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "banana"), #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "grapes"), #imageLiteral(resourceName: "kiwi"), #imageLiteral(resourceName: "peach"), #imageLiteral(resourceName: "watermelon"), #imageLiteral(resourceName: "blueberries"),#imageLiteral(resourceName: "avocado"), #imageLiteral(resourceName: "pineapple"), #imageLiteral(resourceName: "plum"), #imageLiteral(resourceName: "Pear"), #imageLiteral(resourceName: "mango"), #imageLiteral(resourceName: "strawberry"), #imageLiteral(resourceName: "blackberries"), #imageLiteral(resourceName: "cranberries")]
    
    private var fruitNames = ["Apple", "Banana", "Orange", "Grapes", "Kiwi", "Peach", "Watermelon", "Blueberries", "Avocado", "Pineapple", "Plum", "Pear", "Mango", "Strawberry", "Blackberries", "Cranberries"]
    
    private var veggieImages = [#imageLiteral(resourceName: "leafy greens"), #imageLiteral(resourceName: "artichoke"), #imageLiteral(resourceName: "asparagus"), #imageLiteral(resourceName: "mushroom"), #imageLiteral(resourceName: "beet"), #imageLiteral(resourceName: "broccoli"), #imageLiteral(resourceName: "butternut squash"), #imageLiteral(resourceName: "cabbage"), #imageLiteral(resourceName: "lettuce"), #imageLiteral(resourceName: "peas"), #imageLiteral(resourceName: "snap peas"), #imageLiteral(resourceName: "onion"), #imageLiteral(resourceName: "peppers"), #imageLiteral(resourceName: "cauliflower"), #imageLiteral(resourceName: "corn"), #imageLiteral(resourceName: "carrot"), #imageLiteral(resourceName: "spinach"), #imageLiteral(resourceName: "tomato"), #imageLiteral(resourceName: "potato"), #imageLiteral(resourceName: "zuccini"), #imageLiteral(resourceName: "cucumber")]
    
    
    private var veggieNames = ["Leafy Greens", "Artichoke", "Asparagus", "Mushroom", "Beet", "Broccoli", "Butternut Squash","Cabbage", "Lettuce", "Peas", "Snap Peas", "Onion", "Peppers", "Cauliflower", "Corn", "Carrot", "Spinach", "Tomato", "Potato", "Zucchini", "Cucumber"]
    
    
    private var screenNames = ["Television", "Tablet", "Laptop", "Computer", "Smartphone", "Video Games"]
    private var screenImages = [#imageLiteral(resourceName: "television"), #imageLiteral(resourceName: "tablet"), #imageLiteral(resourceName: "laptop"), #imageLiteral(resourceName: "computer"), #imageLiteral(resourceName: "smartphone"), #imageLiteral(resourceName: "videogames")]
    
    private var activityNames = ["Tag", "Soccer", "Basketball", "Roller skating", "Swimming", "Walking", "Running", "Skateboarding", "Jump Rope", "Yoga"]
    private var activityImages = [#imageLiteral(resourceName: "playing tag1"), #imageLiteral(resourceName: "playing soccer"), #imageLiteral(resourceName: "playing basketball"), #imageLiteral(resourceName: "roller skating"), #imageLiteral(resourceName: "swimming"), #imageLiteral(resourceName: "walking"), #imageLiteral(resourceName: "running"), #imageLiteral(resourceName: "skateboarding"), #imageLiteral(resourceName: "jump rope1"), #imageLiteral(resourceName: "yoga1")]
    
    private var drinkNames = ["Sports Drink", "Fruit Drinks", "Soda", "Lemonade", "Flavored Milk", "Iced Tea", "Juice"]
    private var drinkImages = [#imageLiteral(resourceName: "sportsdrink"), #imageLiteral(resourceName: "FruitDrinks"), #imageLiteral(resourceName: "soda"), #imageLiteral(resourceName: "lemonade"), #imageLiteral(resourceName: "flavoredmilk"), #imageLiteral(resourceName: "icedtea"), #imageLiteral(resourceName: "juice")]
    
    private var waterNames = ["Water"]
    private var waterImages = [#imageLiteral(resourceName: "watercup")]

    
    
    var fruitsView = [FoodView]()
    var veggiesView = [FoodView]()
    
    
    
    func numberOfFruits() -> Int {
        return fruitsView.count
    }
    
    func numberOfVegetables() -> Int {
        return veggiesView.count
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
    
    func totalNumberOfServings() -> Double {
        var totalServings: Double = 0.0
            
        for view in veggiesView {
            totalServings += view.count
        }
            
        for view in fruitsView {
            totalServings += view.count
        }
            
        return totalServings
    }
    
    init(forType type: TrackingType) {
        switch type {
        case .FruitsAndVeggies:
            for i in 0 ..< fruitNames.count {
                let image = fruitImages[i]
                let name = fruitNames[i]
                
                let fruit = Food(name: name, image: image)
                
                let foodView = FoodView(frame: CGRect(x: 0.0, y: 0.0, width: 184.0, height: 140.0), food: fruit, type: type)
                
                fruitsView.append(foodView)
            }
            
            
            for i in 0 ..< veggieNames.count {
                let image = veggieImages[i]
                let name = veggieNames[i]
                
                let veggie = Food(name: name, image: image)
                
                
                let foodView = FoodView(frame: CGRect(x: 0.0, y: 0.0, width: 184.0, height: 140.0), food: veggie, type: type)
                
                veggiesView.append(foodView)
            }
        case .ScreenTime:
            for i in 0 ..< screenNames.count {
                let image = screenImages[i]
                let name = screenNames[i]
                
                let screen = Food(name: name, image: image)
                
                let foodView = FoodView(frame: CGRect(x: 0.0, y: 0.0, width: 184.0, height: 140.0), food: screen, type: type)
                
                fruitsView.append(foodView)
            }
            
        case .Activity:
            for i in 0 ..< activityNames.count {
                let image = activityImages[i]
                let name = activityNames[i]
                
                let activity = Food(name: name, image: image)
                
                let foodView = FoodView(frame: CGRect(x: 0.0, y: 0.0, width: 184.0, height: 140.0), food: activity, type: type)
                
                fruitsView.append(foodView)
            }
            
        case .Drinks:
            for i in 0 ..< drinkNames.count {
                let image = drinkImages[i]
                let name = drinkNames[i]
                
                let drinks = Food(name: name, image: image)
                
                let foodView = FoodView(frame: CGRect(x: 0.0, y: 0.0, width: 184.0, height: 140.0), food: drinks, type: type)
                
                fruitsView.append(foodView)
            }
            
            let water = Food(name: "Water", image: #imageLiteral(resourceName: "watercup"))
            
            let foodView = FoodView(frame: CGRect(x: 0.0, y: 0.0, width: 184.0, height: 140.0), food: water, type: type)
            
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





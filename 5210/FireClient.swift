//
//  FireClient.swift
//  5210
//
//  Created by Panucci, Julian R on 3/31/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

//Class to handle all Firebase calls and querys from database
class FireClient {
    
   
    
    static func create(user: User) {
        let ref = FIRDatabase.database().reference()
        let currentUser = FIRAuth.auth()!.currentUser!
        let usersRef = ref.child("users").child(currentUser.uid)
        
        usersRef.setValue(["name" : user.name, "houseName": user.houseName, "age": user.age, "email": user.email, "zip": user.zip])
    }

    static func saveCategory(date: String, type: TrackingType, items: [FoodView]) {
        let ref = FIRDatabase.database().reference()
        let currentUser = FIRAuth.auth()!.currentUser!
        let usersRef = ref.child("users").child(currentUser.uid).child("days").child(date)
        
        
        
        var total = 0.0
        var category: FIRDatabaseReference!
        
        
        switch type {
        case .FruitsAndVeggies:
             category = usersRef.child("five")
        case .ScreenTime:
            category = usersRef.child("two")
        case .Activity:
            category = usersRef.child("one")
        case .Drinks:
            category = usersRef.child("zero")
        }
        
        for item in items {
            total += item.count
            let name = item.foodName
            let count = item.count
            category.updateChildValues([name!: count])
        }
        
        
        category.updateChildValues(["total":total])
    }
    
    static func checkForTodaysStats(forType type: TrackingType, completion: @escaping (_ infoEntered:Bool) -> Void) {
        
        let typeString = type.rawValue
        print(typeString)
        
        
        let ref = FIRDatabase.database().reference()
        let currentUser = FIRAuth.auth()!.currentUser!
        
        let date = Date()
        let calendar = Calendar.current
        let compononents = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year = compononents.year
        let month = compononents.month
        let day = compononents.day
        
        let dateString = "\(month!)\(day!)\(year!)"
        
        let usersRef = ref.child("users").child(currentUser.uid).child("days").child(dateString).child(typeString)
        
        usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists() {
                completion(true)
            }else {
                completion(false)
            }
        })
        
    }
    
    static func currentUser(completion: @escaping (User) -> Void)
    {
        let ref = FIRDatabase.database().reference()
        let currentUser = FIRAuth.auth()!.currentUser!
        
        ref.child("users").child(currentUser.uid).observe(.value, with: { (snapshot) in
            let user = User(snapshot: snapshot)
            completion(user)
        })
    }
    
    static func getTotalForFruits(compltion: @escaping (Double) -> Void) {
        let ref = FIRDatabase.database().reference()
        let currentUser = FIRAuth.auth()!.currentUser!
        
        let date = Date()
        let calendar = Calendar.current
        let compononents = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year = compononents.year
        let month = compononents.month
        let day = compononents.day
        
        let dateString = "\(month!)\(day!)\(year!)"
        
        let usersRef = ref.child("users").child(currentUser.uid).child("days").child(dateString).child("five")
        
        usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let values = snapshot.value as! NSDictionary
            
            let totals = values["total"] as! Double
            
            compltion(totals)
        })
    }
    
    static func getTotalScreenTime(compltion: @escaping (Double) -> Void) {
        let ref = FIRDatabase.database().reference()
        let currentUser = FIRAuth.auth()!.currentUser!
        
        let date = Date()
        let calendar = Calendar.current
        let compononents = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year = compononents.year
        let month = compononents.month
        let day = compononents.day
        
        let dateString = "\(month!)\(day!)\(year!)"
        
        let usersRef = ref.child("users").child(currentUser.uid).child("days").child(dateString).child("two")
        
        usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let values = snapshot.value as! NSDictionary
            
            let totals = values["total"] as! Double
            
            compltion(totals)
        })
    }
    
    static func getTotalForActivity(compltion: @escaping (Double) -> Void) {
        let ref = FIRDatabase.database().reference()
        let currentUser = FIRAuth.auth()!.currentUser!
        
        let date = Date()
        let calendar = Calendar.current
        let compononents = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year = compononents.year
        let month = compononents.month
        let day = compononents.day
        
        let dateString = "\(month!)\(day!)\(year!)"
        
        let usersRef = ref.child("users").child(currentUser.uid).child("days").child(dateString).child("one")
        
        usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let values = snapshot.value as! NSDictionary
            
            let totals = values["total"] as! Double
            
            compltion(totals)
        })
    }
    
    static func getDrinks(compltion: @escaping (Double, Double) -> Void) {
        let ref = FIRDatabase.database().reference()
        let currentUser = FIRAuth.auth()!.currentUser!
        
        let date = Date()
        let calendar = Calendar.current
        let compononents = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year = compononents.year
        let month = compononents.month
        let day = compononents.day
        
        let dateString = "\(month!)\(day!)\(year!)"
        
        let usersRef = ref.child("users").child(currentUser.uid).child("days").child(dateString).child("zero")
        
        usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let values = snapshot.value as! NSDictionary
            
            let totals = values["total"] as! Double
            let water = values["Water"] as! Double
            let sugarDrinks = totals - water
            
            compltion(water, sugarDrinks)
        })
    }
        
        
    
    
    
    
}

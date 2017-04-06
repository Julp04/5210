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

    
    
    
    
}

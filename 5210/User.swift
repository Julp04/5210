//
//  User.swift
//  QNect
//
//  Created by Julian Panucci on 11/6/2016
//  Copyright © 2016 Julian Panucci. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import UIKit

class User
{
    var uid: String!
    var email: String!
    var houseName: String!
    var name: String!
    var age: Int!
    var zip: Int!
    
    
    var ref: FIRDatabaseReference?
    var key: String?
    
    var profileImage: UIImage?

    
    
    init(snapshot:FIRDataSnapshot) {
        
        let values = snapshot.value as! NSDictionary
        
        self.name = values["name"] as! String
        self.houseName = values["houseName"] as! String
        self.uid = values["uid"] as! String
        self.email = values["email"] as! String
        self.age = values["age"] as! Int
        self.zip = values["zip"] as! Int
        self.key = snapshot.key
        self.ref = snapshot.ref
        
    }
    
    
    init(name: String, houseName: String, age: Int, zip: Int ,uid:String, email:String) {
        self.name = name
        self.houseName = houseName
        self.age = age
        self.zip = zip
        
        self.uid = uid
        self.email = email
    }
    
  
}





//
//  SignupViewController.swift
//  5210
//
//  Created by Panucci, Julian R on 3/31/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignupViewController: UIViewController {
    
    
    //MARK: Outlets
    
    //MARK: Actions
    
    //MARK: Properties
    
    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    //MARK: Functionality
    
    func signup() {
        FIRAuth.auth()?.createUser(withEmail: emailField.text, password: passwordField.text, completion: { (user, error) in
            guard error == nil else {
                AlertUtility.showErrorAlert(error: error!)
                return
            }
            
            FIRAuth.auth()?.signIn(withEmail: emailField.text, password: passwordField.text, completion: { (user, error) in
                guard error == nil else {
                    AlertUtility.showErrorAlert(error: error)
                }
                
                segueToHomeScreen()
                
            })
        })
    }
    
    
    //MARK: Segue
    
    func segueToHomeScreen() {
        
    }

}

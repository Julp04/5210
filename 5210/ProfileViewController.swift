//
//  ProfileViewController.swift
//  5210
//
//  Created by Panucci, Julian R on 4/6/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import UIKit

import FirebaseAuth
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (action) in
            try! FIRAuth.auth()?.signOut()
            
            let onboardViewCoontroller = self.storyboard?.instantiateViewController(withIdentifier: "OnboardViewController") as! UINavigationController
            self.present(onboardViewCoontroller, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

}

//
//  SignupController.swift
//  5210
//
//  Created by Panucci, Julian R on 4/1/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SkyFloatingLabelTextField
import JPLoadingButton

class SignupController: UIViewController {

    
    //MARK: Outlets
    
    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var nameField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!
    @IBOutlet weak var zipField: SkyFloatingLabelTextField!
    @IBOutlet weak var signupButton: JPLoadingButton!
    
    //MARK: Actions
    
    @IBAction func signupAction(_ sender: Any) {
    }
    //MARK: Properties
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addProfileImageButton()
        
    }
    
    //MARK: UI
    
    func addProfileImageButton() {
        let button = UIButton(frame: profileImageView.frame)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(SignupController.changeAvatar), for: .touchUpInside)
        button.layer.cornerRadius = profileImageView.layer.cornerRadius
        button.layer.masksToBounds = true
        view.addSubview(button)
    }
    
    
    
    
    //MARK: Functionality
    
    func signup() {
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
            guard error == nil else {
                AlertUtility.showErrorAlert(error: error!)
                return
            }
            
            FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                guard error == nil else {
                    AlertUtility.showErrorAlert(error: error!)
                    return
                }
                
                self.segueToHomeScreen()
                
            })
        })
    }
    
    func changeAvatar() {
        print("Present avatar screen")
    }
    
    
    //MARK: Segue
    
    func segueToHomeScreen() {
        
    }

}

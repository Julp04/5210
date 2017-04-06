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
    
    
    @IBOutlet weak var houseField: SkyFloatingLabelTextField!
    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var nameField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!
    @IBOutlet weak var zipField: SkyFloatingLabelTextField!
    @IBOutlet weak var signupButton: JPLoadingButton!
    
    @IBOutlet weak var ageField: SkyFloatingLabelTextField!
    //MARK: Actions
    
    @IBAction func signupAction(_ sender: Any) {
        signup()
    }
    //MARK: Properties
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addProfileImageButton()
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9699707031, green: 0.3545121978, blue: 0.5182423858, alpha: 1)
        self.navigationController?.navigationBar.isHidden = false
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
                let newUser = User(name: self.nameField.text!, houseName: self.houseField.text!, age: Int(self.ageField.text!)!, zip: Int(self.zipField.text!)!, uid: (user?.uid)!, email: (user?.email)!)
                
                FireClient.create(user: newUser)
                
                self.segueToHomeScreen()
                
            })
        })
    }
    
    func changeAvatar() {
        print("Present avatar screen")
    }
    
    
    //MARK: Segue
    
    func segueToHomeScreen() {
    
        performSegue(withIdentifier: "Five210Segue", sender: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

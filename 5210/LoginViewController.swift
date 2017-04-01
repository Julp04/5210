//
//  LoginViewController.swift
//  QNect
//
//  Created by Julian Panucci on 11/6/16.
//  Copyright © 2016 Julian Panucci. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import RKDropdownAlert
import FCAlertView
import SkyFloatingLabelTextField
import FontAwesome_swift
import JPLoadingButton


class LoginViewController: UIViewController {
    
    //MARK: Properties
    
    var ref: FIRDatabaseReference!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: Outlets
    
    @IBOutlet weak var emailField: SkyFloatingLabelTextFieldWithIcon! {
        didSet {
            emailField.iconFont = UIFont.fontAwesome(ofSize: 15)
            emailField.iconText = "\u{f007}"
            
            emailField.selectedIconColor = #colorLiteral(red: 0.1168564659, green: 0.5970480165, blue: 1, alpha: 1)
            emailField.iconMarginBottom = -2.0
            
            emailField.delegate = self
        }
    }
    @IBOutlet weak var passwordField: SkyFloatingLabelTextFieldWithIcon! {
        didSet {
            passwordField.iconFont = UIFont.fontAwesome(ofSize: 15)
            passwordField.iconText = "\u{f023}"
            
            passwordField.selectedIconColor = #colorLiteral(red: 0.1168564659, green: 0.5970480165, blue: 1, alpha: 1)
            passwordField.iconMarginBottom = -2.0
            
            passwordField.delegate = self
        }
    }
    @IBOutlet weak var loginButton: JPLoadingButton!
    
    //MARK: Actions
    
    @IBAction func loginAction(_ sender: Any) {
        loginUser()
    }
    @IBAction func forgotPasswordAction(_ sender: Any) {
        forgotPassword()
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9687103426, green: 0.4208184945, blue: 0, alpha: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : #colorLiteral(red: 0.9687103426, green: 0.4208184945, blue: 0, alpha: 1),
                                    NSFontAttributeName : UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightRegular)]
        
        
        self.view.backgroundColor = UIColor.white
    }
    
    //MARK: User Interaction
    
    func loginUser()
    {
        loginButton.startLoadingAnimation()
        loginWithEmail()
    }
    
    func loginWithEmail()
    {
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!) { user, error in
            
            if error != nil {
                guard self.emailField.text != nil else {
                    self.emailField.errorMessage = "Invalid Email"
                    self.loginButton.stopLoadingAnimation()
                    return
                }
                
                self.passwordField.errorMessage = "Invalid Password"
                self.loginButton.stopLoadingAnimation()
            }else {
                //Animate to main view controller
                //todo: Fix storyboard animation
                let mainVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "MainControllerNav") as! UINavigationController
                self.loginButton.startFinishAnimationWith(currentVC: self, viewController: mainVC)
            }
        }
    }
    
    func forgotPassword()
    {
        var hitReset = 0
        
        var email = ""
        let alert = FCAlertView()
        
        alert.addTextField(withPlaceholder: "Email") { (string) in
            email  = string!
            
            if hitReset == 1 {
                if email != "" {
                    FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
                        if error != nil {
                            RKDropdownAlert.title("\(email) is not a registered user", backgroundColor: UIColor.red, textColor: UIColor.white)
                        }else {
                            RKDropdownAlert.title("Password Reset Email Sent!", message: "Check your inbox for a link to reset", backgroundColor: UIColor.green, textColor: UIColor.white)
                        }
                    })
                }else {
                    RKDropdownAlert.title("Email cannot be blank", backgroundColor: UIColor.red, textColor: UIColor.white)
                }
            }
        }
        
        alert.addButton("Cancel", withActionBlock: {
            hitReset = 0
        })
        alert.doneActionBlock {
            hitReset = 1
        }
        alert.colorScheme = #colorLiteral(red: 0.9687103426, green: 0.4208184945, blue: 0, alpha: 1)
        alert.showAlert(inView: self, withTitle: "Reset Password", withSubtitle: "Please enter your email and we'll send a link to reset it!", withCustomImage:#imageLiteral(resourceName: "lock") , withDoneButtonTitle: "Reset Password", andButtons: nil)
    }
    
    //MARK:Helper Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        passwordField.errorMessage = ""
        emailField.errorMessage = ""
        var password = passwordField.text
        var email = emailField.text
        
        
        if textField == passwordField {
            if string == "" {
                password?.characters.removeLast()
            }else {
                password?.characters.append(string.characters.first!)
            }
        }
        
        if textField == emailField {
            if string == "" {
                email?.characters.removeLast()
            }else {
                email?.characters.append(string.characters.first!)
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }else {
            loginUser()
        }
        return true
    }
    
}


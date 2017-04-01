//
//  AlertUtility.swift
//  QNect
//
//  Created by Panucci, Julian R on 2/9/17.
//  Copyright © 2017 Julian Panucci. All rights reserved.
//

import Foundation
import RKDropdownAlert

class AlertUtility {
    
    
    
    static func showConnectionAlert()
    {
        RKDropdownAlert.title("No Internet Connection", message: "Please connect to the interwebs and try again", backgroundColor: #colorLiteral(red: 0.818329632, green: 0.02533760283, blue: 0.04497174916, alpha: 1), textColor: .white)
    }
    
    static func showErrorAlert(error: Error) {
        RKDropdownAlert.title("Oops!", message: error.localizedDescription, backgroundColor: #colorLiteral(red: 0.818329632, green: 0.02533760283, blue: 0.04497174916, alpha: 1), textColor: .white)
    }
}

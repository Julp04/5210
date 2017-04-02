//
//  Five210NavBar.swift
//  5210
//
//  Created by Panucci, Julian R on 4/2/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import UIKit

class Five210NavBar: UINavigationBar {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white,
                                    NSFontAttributeName : UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightRegular)]
        self.tintColor = UIColor.white.withAlphaComponent(0.7)
        
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        

        let titleImage = #imageLiteral(resourceName: "5210_logo_small")
        let titleView = UIImageView(image: titleImage)
        self.topItem?.titleView = titleView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

//
//  OnboardViewController.swift
//  QNect
//
//  Created by Panucci, Julian R on 2/21/17.
//  Copyright © 2017 Julian Panucci. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class OnboardViewController: UIViewController {
    
    //MARK: Constants
    
    let kTitleFontSize:CGFloat = 23
    let kTitleYOffsetLength:CGFloat = 90
    let kTitleHeight:CGFloat = 30
    
    let kSubtitleFontSize:CGFloat = 17
    let kSubtitleHeight:CGFloat = 110
    let kSubtitleYOffsetLength:CGFloat = 30
    
    //MARK: Properties
    
    var backgroundPlayer : BackgroundVideo? // Declare an instance of BackgroundVideo called backgroundPlayer
    
    let titleArray = ["Welcome", "5", "2", "1", "0"]
    let subtitleArray = ["Welcome to 5210! Keeping your kids healthy and active has never been as easy as...", "Eat healthy and smart by eating 5 or more fruits and vegetables a day", "Stay focused by limitin screen time to two hours a day", "Stay fit by excersing and playing at least 1 hour a day", "Consume more water and drink 0 sugary drinks each day"]
    
    let imageArray = [#imageLiteral(resourceName: "5210"),#imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "0")]
    let colorArray = [#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), #colorLiteral(red: 0.818329632, green: 0.02533760283, blue: 0.04497174916, alpha: 1), #colorLiteral(red: 0.9687103426, green: 0.4208184945, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.5929370241, blue: 0.1599473397, alpha: 1), #colorLiteral(red: 0.1168564659, green: 0.5970480165, blue: 1, alpha: 1)]
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //MARK: Outlets
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9699707031, green: 0.3545121978, blue: 0.5182423858, alpha: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : #colorLiteral(red: 0.9699707031, green: 0.3545121978, blue: 0.5182423858, alpha: 1),
                                                                        NSFontAttributeName : UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightRegular)]
        
        configureScrollView()
        
        self.pageControl.numberOfPages = titleArray.count
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: Setup
    
    func configureScrollView()
    {
        let size = view.bounds.size
        let contentSize = CGSize(width: size.width * CGFloat(titleArray.count), height: size.height)
        
        scrollView.contentSize = contentSize
        scrollView.isPagingEnabled = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.delegate = self
        
        configureContentInScrollView()
    }
    
    func configureContentInScrollView()
    {
        
        for i in 0..<titleArray.count {
            
            let color = colorArray[i]
        
            let size = view.bounds.size
            
            let xOffset = (size.width * CGFloat(i))
            let yOffset = size.height / 2.0 + kTitleYOffsetLength
            
            let imageView = UIImageView(frame: CGRect(x: xOffset + 90, y: yOffset - 230, width: 200, height: 200))
            imageView.contentMode = .scaleAspectFit
            imageView.image = imageArray[i]
            
            
            let titleFrame = CGRect(x: xOffset, y: yOffset, width: size.width - 10, height: kTitleHeight)
            let titleLabel = UILabel(frame: titleFrame)
            titleLabel.text = titleArray[i]
            titleLabel.textColor = color
            
            let normalFont = UIFont(name: "Gill Sans", size: kTitleFontSize)!
            let boldFont = UIFont(descriptor: normalFont.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits.traitBold)!, size: kTitleFontSize)
            
            titleLabel.font = boldFont
            titleLabel.textAlignment = .center
            
            let subtitleFrame = CGRect(x: xOffset + 10, y: yOffset + kSubtitleYOffsetLength, width: size.width - 20, height: kSubtitleHeight)
            let subtitleTextView = UITextView(frame: subtitleFrame)
            subtitleTextView.allowsEditingTextAttributes = false
            subtitleTextView.text = subtitleArray[i]
            subtitleTextView.textAlignment = .center
            
            let subtitleFont = UIFont(name: "Helvetica Neue", size: kSubtitleFontSize)
            subtitleTextView.font = subtitleFont
            subtitleTextView.backgroundColor = UIColor.clear
            subtitleTextView.textColor = color
            subtitleTextView.isScrollEnabled = false
            subtitleTextView.isEditable = false
            subtitleTextView.isUserInteractionEnabled = false
            
            scrollView.addSubview(titleLabel)
            scrollView.addSubview(subtitleTextView)
            scrollView.addSubview(imageView)
        }
    }
}

extension OnboardViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = self.scrollView.frame.size.width;
        let fractionalPage = self.scrollView.contentOffset.x / pageWidth
        let page = lround(Double(fractionalPage));
        self.pageControl.currentPage = page;
        
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}

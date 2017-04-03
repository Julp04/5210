//
//  FoodView.swift
//  5210
//
//  Created by Panucci, Julian R on 4/2/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import UIKit
import AVFoundation

protocol ServingsDelegate: class {
    func countChanged()
}

@IBDesignable
class FoodView: UIView {
    
    var player: AVAudioPlayer?
    
   
    
    //MARK: Constants
    
    let kControlsHeight: CGFloat = 30
    let kButtonWidth: CGFloat = 46
    let kNameLabelHeight: CGFloat = 21
    weak var delegate: ServingsDelegate?
    
    
    @IBInspectable var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    @IBInspectable var foodName: String? {
        didSet {
            nameLabel.text = foodName
        }
    }
    
    private var imageView: UIImageView!
    private var minusButton: UIButton!
    private var plusButton: UIButton!
    private var addButton: UIButton!
    
    private var countLabel: UILabel!
    private var nameLabel: UILabel!
    private var labelView: UIView!
    
    private var imageViewHeight: CGFloat!
    private var labelWidth: CGFloat!
    
    var food: Food!
    
    var count: Int = 0 {
        didSet {
            addButton.isHidden = count > 0
            countLabel.text = String(count)
            delegate?.countChanged()
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        
        
        super.init(coder: aDecoder)
        
        imageViewHeight = frame.height - kControlsHeight
        labelWidth = frame.width - 2 * kButtonWidth
        
        setupButtons()
        setupImageView()
        setupLabelView()
        
        addSubview(imageView)
        addSubview(minusButton)
        addSubview(plusButton)
        addSubview(labelView)
        addSubview(addButton)
    }
    
   
    
    init(frame: CGRect, food: Food) {
        self.food = food
        super.init(frame: frame)
        backgroundColor = .white
        
        self.image = food.image
        self.foodName = food.name
        
     
        imageViewHeight = frame.height - kControlsHeight
        labelWidth = frame.width - 2 * kButtonWidth
        
        setupButtons()
        setupImageView()
        setupLabelView()
        
        
        
        addSubview(imageView)
        addSubview(minusButton)
        addSubview(plusButton)
        addSubview(labelView)
        addSubview(addButton)
        addSubview(nameLabel)
        bringSubview(toFront: nameLabel)
        
       
    }
    
    
    

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
    }
    
    private func setupButtons() {
       
        let buttonFrame = CGRect(x: 0, y: imageViewHeight, width: kButtonWidth, height: kControlsHeight)
        
        minusButton = UIButton(frame: buttonFrame)
        minusButton.setTitle("-", for: .normal)
        minusButton.backgroundColor = #colorLiteral(red: 0.2823529412, green: 0.6588235294, blue: 0.2588235294, alpha: 1)
        minusButton.addTarget(self, action: #selector(FoodView.decrementCount), for: .touchUpInside)
        
        plusButton = UIButton(frame: CGRect(x: kButtonWidth + labelWidth, y: imageViewHeight, width: kButtonWidth, height: kControlsHeight))
        plusButton.setTitle("+", for: .normal)
        plusButton.backgroundColor =  #colorLiteral(red: 0.2823529412, green: 0.6588235294, blue: 0.2588235294, alpha: 1)
        plusButton.addTarget(self, action: #selector(FoodView.incrementCount), for: .touchUpInside)
        
        
        addButton = UIButton(frame:CGRect(x: 0, y: imageViewHeight, width: frame.width, height: kControlsHeight))
        addButton.setTitle("+ Add", for: .normal)
        addButton.backgroundColor = #colorLiteral(red: 0.934858501, green: 0.2402378321, blue: 0.2590747476, alpha: 1)
        addButton.addTarget(self, action: #selector(FoodView.incrementCount), for: .touchUpInside)
    }
    
    private func setupLabelView() {
        countLabel = UILabel(frame: CGRect(x: labelWidth / 2.0 - 5.0, y: 0, width: labelWidth, height: kControlsHeight))
        countLabel.text = "1"
        countLabel.contentMode = .center
        
        let labelFrame = CGRect(x: kButtonWidth, y: imageViewHeight, width: labelWidth, height: kControlsHeight)
        labelView = UIView(frame: labelFrame)
        labelView.backgroundColor = .white
        labelView.addSubview(countLabel)
        
        nameLabel = UILabel(frame: CGRect(x: 20 + labelWidth / 2.0, y: imageViewHeight - kNameLabelHeight, width: frame.width, height: kNameLabelHeight))
        nameLabel.contentMode = .center
        nameLabel.text = self.foodName
    
    }
    
    private func setupImageView() {
        imageView = UIImageView(frame: CGRect(x: kButtonWidth, y: 0, width: labelWidth, height: imageViewHeight - kNameLabelHeight))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
    }
    
    internal func incrementCount() {
        food.numberOfServings += 1
        count += 1
        
        playSound()
    }
    
    internal func decrementCount() {
        guard count >= 0 else {
            return
        }
        food.numberOfServings -= 1
        count -= 1
        
    }
    
    func playSound() {
        
        let foodName = food.name.removingWhitespaces().lowercased()
        let url = Bundle.main.url(forResource: "\(foodName)", withExtension: "wav")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }


}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

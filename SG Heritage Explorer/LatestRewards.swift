//
//  LatestRewards.swift
//  SG Heritage Explorer
//
//  Created by Mohamed Imran on 27/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import UIKit

 @IBDesignable class LatestRewards: UIStackView {

   //Properties
    @IBInspectable var rewardsSize:CGSize = CGSize(width: 80.0, height: 10.0){
    
    
    didSet {
    
       setupButtons()
    
    }
    
    }
    
    @IBInspectable var rewardsCount: Int = 6 {
        
        didSet {
            setupButtons()
        }
        
    }
    
    
    //Create a list of buttons 
    private var RewardsButton = [UIButton]()
    
    //Create a list of ImageArray 
    private var ImageArray = [UIImage]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    
    //Private functions 
    private func setupButtons() {
        
        ImageArray.removeAll()
        
        
//        //Images 
        ImageArray.append(#imageLiteral(resourceName: "UniversalStudios.png"))
        ImageArray.append(#imageLiteral(resourceName: "UniversalStudios.png"))
        ImageArray.append(#imageLiteral(resourceName: "UniversalStudios.png"))
        ImageArray.append(#imageLiteral(resourceName: "UniversalStudios.png"))
        ImageArray.append(#imageLiteral(resourceName: "UniversalStudios.png"))
        ImageArray.append(#imageLiteral(resourceName: "UniversalStudios.png"))
//        ImageArray.append(#imageLiteral(resourceName: "directionsIcon"))
//        ImageArray.append(#imageLiteral(resourceName: "directionsIcon"))
//        ImageArray.append(#imageLiteral(resourceName: "directionsIcon"))
//        ImageArray.append(#imageLiteral(resourceName: "directionsIcon"))
//        ImageArray.append(#imageLiteral(resourceName: "directionsIcon"))
        
        //Clear the existing button in the array 
        //Clear the existing button in the array
        for buttons in RewardsButton {
            
            removeArrangedSubview(buttons)
            buttons.removeFromSuperview()
        }
        
        //Clear the array
        RewardsButton.removeAll()
        
        
       
        
        

       
        
        for i in 0..<4{
            
            //Create UI Button
            let Rewards = UIButton()
            //Rewards.backgroundColor = UIColor(red: 17.0/255.0, green: 119.0/255.0, blue: 151.0/255.0, alpha: 1.0)
            
            //Set Button Images
            Rewards.setImage(UIImage(named:"UniversalStudios.png"), for: .normal)
            
            //Add Contraints
            Rewards.translatesAutoresizingMaskIntoConstraints = false
            Rewards.heightAnchor.constraint(equalToConstant: rewardsSize.height).isActive = true
            Rewards.widthAnchor.constraint(equalToConstant: rewardsSize.width).isActive = true
            
            
            //Setup the button action
            Rewards.addTarget(self, action: #selector(LatestRewards.latestRewardsPressed(button:)), for: .touchUpInside)
            
            //Add button to the stack
            addArrangedSubview(Rewards)
            
            // Add the newbutton to RewardsButton array
            RewardsButton.append(Rewards)
            
            print((RewardsButton.count))

            
        }
        
    }
    
    //Button press function method 
    func latestRewardsPressed(button: UIButton){
        print("Rewards button pressed")
    }

}

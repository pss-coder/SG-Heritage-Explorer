//
//  QuizControl.swift
//  One Map
//
//  Created by Mohamed Imran on 21/9/17.
//  Copyright © 2017 Mohamed Imran. All rights reserved.
//

import UIKit

@IBDesignable class QuizControl: UIStackView {
    
    
    //Properties
    
    //Create Two buttons
    var True:UIButton;
    var False:UIButton;
    
    
    override init(frame: CGRect) {
        True = UIButton()
        False = UIButton()
        super.init(frame: frame)
        
        
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        True = UIButton()
        False = UIButton()
        super.init(coder: coder)
        
        
        setupButtons()
    }
    
    
    
    // Private methods
    
    private func setupButtons() {
        
        
        
        
        //True Button
        //Create UI Button
       
        True.backgroundColor = UIColor(red: 17.0/255.0, green: 119.0/255.0, blue: 151.0/255.0, alpha: 1.0)
        True.setTitle("True", for: .normal)
        //Add Contraints
        True.translatesAutoresizingMaskIntoConstraints = false
        True.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        True.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        
        
        //Setup the button action
       // True.addTarget(self, action: #selector(QuizControl.truebuttonPressed(button:)), for: .touchUpInside)
        
        //Add Button to Stack
        addArrangedSubview(True)
        
        //False Button
        //Create Button
        
        False.backgroundColor = UIColor.red
        False.setTitle("False", for: .normal)
        
        //Constraints
        False.translatesAutoresizingMaskIntoConstraints = false
        False.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        False.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        
        //Setup button action
        //False.addTarget(self, action: #selector(QuizControl.falseButtonPressed(button:)), for: .touchUpInside)
        
        
        //Add the button to the stack
        addArrangedSubview(False)
        
        
        
        
        
    }
    
    //Actions
//    func truebuttonPressed(button: UIButton){
//       // print("True Button Pressed")
//        
//        
//        //UserAnswer(UserAnswer: "True")
//        
//        
//        
//    }
//    
//    func falseButtonPressed(button: UIButton){
//       // print("False Button Pressed")
//    }
//    
//    
    
    
}



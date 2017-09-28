//
//  ResultsViewController.swift
//  SG Heritage Explorer
//
//  Created by Mohamed Imran on 28/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    //Properties 
    public var Quiz1Question:String = "";
    public var Quiz1Useranswer:String = "";
    public var Quiz1Correctanswer:String = "";


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("The Bloody Results")
        print(self.Quiz1Question + self.Quiz1Useranswer + self.Quiz1Correctanswer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    
}

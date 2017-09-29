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

    @IBOutlet weak var PointsView: UIView!
    @IBOutlet weak var Quiz1View: UIView!
    @IBOutlet weak var Quiz2View: UIView!

    @IBOutlet weak var quiz1question: UILabel!
    @IBOutlet weak var quiz1ans: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        PointsView.layer.cornerRadius = 10
        PointsView.layer.borderWidth = 1
        PointsView.layer.borderColor = UIColor.black.cgColor
        
        Quiz1View.layer.cornerRadius = 10
        Quiz1View.layer.borderWidth = 1
        Quiz1View.backgroundColor = UIColor.white.withAlphaComponent(0.5)

        
        Quiz2View.layer.cornerRadius = 10
        Quiz2View.layer.borderWidth = 1
        Quiz2View.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        
        
        
        
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

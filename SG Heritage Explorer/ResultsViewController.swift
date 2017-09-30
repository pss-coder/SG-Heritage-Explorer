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
    public var PicQuizQuestion:String = "";
    public var Quiz1Points:Int = 0
    public var Quiz2Points:Int = 0
    public var totalquizpoints:Int = 40

    @IBOutlet weak var PointsView: UIView!
    @IBOutlet weak var Quiz1View: UIView!
    @IBOutlet weak var Quiz2View: UIView!

    @IBOutlet weak var quiz1question: UILabel!
    @IBOutlet weak var quiz1ans: UILabel!
    @IBOutlet weak var PictureQuizQuestion: UILabel!
    
    @IBOutlet weak var quiz1Image: UIImageView!
    @IBOutlet weak var PointsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        
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
    
    func Results() {
    quiz1question.text = self.Quiz1Question
    print(self.Quiz1Question)
    if(self.Quiz1Useranswer == self.Quiz1Correctanswer){
    quiz1ans.text = self.Quiz1Useranswer
    //quiz1ans.textColor = UIColor.green
    quiz1Image.image = UIImage(named:"tick-inside-a-circle")
    PictureQuizQuestion.text = PicQuizQuestion
        
   //Calculating points
    Quiz1Points = 20
    Quiz2Points = 20
    PointsLabel.text = " \(Quiz1Points + Quiz2Points) / \(totalquizpoints)"
    
        
    
    
    }else {
    quiz1ans.text = self.Quiz1Useranswer
    //quiz1ans.textColor = UIColor.red
    quiz1Image.image = UIImage(named:"cancel-symbol-inside-a-circle")
    PictureQuizQuestion.text = PicQuizQuestion
    //Calculating points
    Quiz1Points = 0
    Quiz2Points = 20
    PointsLabel.text = " \(Quiz1Points + Quiz2Points) / \(totalquizpoints)"

    }

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        Results()
        
        print("The Bloody Results")
        print(self.Quiz1Question + self.Quiz1Useranswer + self.Quiz1Correctanswer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    
}

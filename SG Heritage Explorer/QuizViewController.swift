//
//  QuizViewController.swift
//  SG Heritage Explorer
//
//  Created by Mohamed Imran on 27/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    //properties
    var passedTitle:String!
    
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var quizControl: QuizControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Callig the function to set the questions based on the location title
        QuestionAnswers(User: "")
        
        print("Passed Title")
        print(passedTitle)

        //Setting up the button action for the quiz control true button
        quizControl.True.addTarget(self, action: #selector(QuizViewController.truebuttonPressed(button:)), for: .touchUpInside)
        //Setting up the button action for the quiz control false button
        quizControl.False.addTarget(self, action: #selector(QuizViewController.falsebuttonPressed(button:)), for: .touchUpInside)

    
        
 }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //True button action click
    func truebuttonPressed(button: UIButton){
        print("True Button Clicked")
        QuestionAnswers(User: "True")
    }
    
    //False button action click
    func falsebuttonPressed(button: UIButton){
        print("False button Clicked")
        QuestionAnswers(User: "False")
    }
    
    
     func QuestionAnswers(User: String) {
        
        
        if (passedTitle == "Merlion Park"){
            
            let quiz1 = Quiz(Questions: "Is there 7 merlions in Singapore?", CorrectAnswer: "False")
            
            QuestionLabel.text = quiz1.Questions
            
            if (quiz1.CorrectAnswer == User){
                print("Correct")
            }
            else{
                print("Wrong")
            }
            
        }
        else if(passedTitle == "Raffles Statue"){
            
            let quiz1 = Quiz(Questions: "Is the statue at Victoria memorial hall", CorrectAnswer: "True")
            QuestionLabel.text = quiz1.Questions
            
            if (quiz1.CorrectAnswer == User){
                print("Correct")
            }
            else{
                print("Wrong")
            }
            
            
        }
        else if (passedTitle == "Singapore Botanic Gardens") {
            
            let quiz1 = Quiz(Questions: "Is Singapore Botanic Garden a UNESCO World heritage site?", CorrectAnswer: "True")
            QuestionLabel.text = quiz1.Questions
            
            if (quiz1.CorrectAnswer == User){
                print("Correct")
            }
            else{
                print("Wrong")
            }
            
            
            
            
        }
        
        
        
    }

    
    
    

   
}

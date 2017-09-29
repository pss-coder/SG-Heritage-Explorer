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
    
    var SavedQuestion = ""
    
    var SavedUseranswer = ""
    
    var SavedCorrectanswer = ""
    
    @IBOutlet weak var DescriptionBox: UIView!
    
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var quizControl: QuizControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DescriptionBox.backgroundColor = .clear
        DescriptionBox.layer.cornerRadius = 10
        DescriptionBox.layer.borderWidth = 1
        DescriptionBox.layer.borderColor = UIColor.white.cgColor
        
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
    
   
    @IBAction func BackBtn(_ sender: Any) {
        
        //Navigating to Picture Quiz
       
        
        self.dismiss(animated: true, completion: nil);
        
    }
    
    //True button action click
    func truebuttonPressed(button: UIButton){
        print("True Button Clicked")
        QuestionAnswers(User: "True")
        
        //Navigating to Picture Quiz 
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let PicController = storyboard.instantiateViewController(withIdentifier: "PicQuiz") as! PictureQuizViewController
        self.present(PicController, animated: true, completion: nil)
        
        //Save all the results and pass it the next quiz
        PicController.Quiz1Question = SavedQuestion
        PicController.Quiz1Useranswer = SavedUseranswer
        PicController.Quiz1Correctanswer = SavedCorrectanswer
        

    
        
        
        
    }
    
    //False button action click
    func falsebuttonPressed(button: UIButton){
        print("False button Clicked")
        QuestionAnswers(User: "False")
        
        //Navigating to Picture Quiz
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let PicController = storyboard.instantiateViewController(withIdentifier: "PicQuiz") as! PictureQuizViewController
        self.present(PicController, animated: true, completion: nil)
        
        //Save all the results and pass it the Picture quiz
        PicController.Quiz1Question = SavedQuestion
        PicController.Quiz1Useranswer = SavedUseranswer
        PicController.Quiz1Correctanswer = SavedCorrectanswer

        

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
            
            
            //Save all the results
            SavedQuestion = quiz1.Questions
            SavedUseranswer = User
            SavedCorrectanswer = quiz1.CorrectAnswer
            
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
            
            //Save all the results
            SavedQuestion = quiz1.Questions
            SavedUseranswer = User
            SavedCorrectanswer = quiz1.CorrectAnswer
            
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
            
            //Save all the results
            SavedQuestion = quiz1.Questions
            SavedUseranswer = User
            SavedCorrectanswer = quiz1.CorrectAnswer
            
            
        }
        
        
        
    }

    
    
    

   
}

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
    @IBOutlet weak var LocationDescription: UILabel!
    @IBOutlet weak var LocationTitle: UILabel!
    
    var passedTitle:String!
    
    var SavedQuestion = ""
    
    var SavedUseranswer = ""
    
    var SavedCorrectanswer = ""
    
    var PictureQuestion = ""
    
        
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
        PicController.PicQuizQuestion = PictureQuestion
        

    
        
        
        
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
        PicController.PicQuizQuestion = PictureQuestion

        

    }
    
    
     func QuestionAnswers(User: String) {
        
        
        if (passedTitle == "Merlion Park"){
            
            let quiz1 = Quiz(Questions: "Is there 7 merlions in Singapore?", CorrectAnswer: "False")
            LocationTitle.text = passedTitle
            QuestionLabel.text = quiz1.Questions
            LocationDescription.text = "Merlion Park, is a Singapore landmark and major tourist attraction, located at One Fullerton, Singapore, near the Central Business District (CBD). The Merlion is a mythical creature with a lion's head and the body of a fish that is widely used as a mascot and national personification of Singapore. "
            PictureQuestion = "Post a selfie with the merlion"
            
            
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
            LocationTitle.text = passedTitle
            QuestionLabel.text = quiz1.Questions
            LocationDescription.text = "The statue was the work of the famed British sculptor-cum-poet Thomas Woolner. The statue was unveiled by then Governor of the Straits Settlements Frederick Weld on 27 June 1887 on the occasion of Queen Victoria's Golden Jubilee. A little known detail was added by Woolner at the base of the statue. Here, he had traced a map depicting the area around the Straits of Malacca to symbolise Raffles having set foot on British Malaya."
            PictureQuestion = "Post a selfie with raffle's statue"
            
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
            LocationTitle.text = passedTitle
            QuestionLabel.text = quiz1.Questions
            LocationDescription.text = "The Singapore Botanic Gardens is a 158-year-old tropical garden located at the fringe of Singapore's Orchard Road shopping district. It is one of three gardens, and the only tropical garden, to be honoured as a UNESCO World Heritage Site. The Botanic Gardens has been ranked Asia's top park attraction since 2013, by TripAdvisor Travellers' Choice Awards."
            PictureQuestion = "Post a selfie in botanic garden"
            
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

//
//  PictureQuizViewController.swift
//  SG Heritage Explorer
//
//  Created by Mohamed Imran on 28/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import UIKit

class PictureQuizViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //Properties 
    @IBOutlet weak var photoImageView: UIImageView!

    public var Quiz1Question:String = "";
    public var Quiz1Useranswer:String = "";
    public var Quiz1Correctanswer:String = "";
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func PhotoButtonAction(_ sender: Any) {
        showActionSheet()
    }
    
    
    func showActionSheet(){
        
        let actionSheet = UIAlertController(title: "Upload Photo", message: "Quiz", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let takepicture = UIAlertAction(title: "Take Picture", style: .default) { (action) in
            // Implement action
            self.TakePhoto()
            
            
        }
        
        let choosepicture = UIAlertAction(title: "Choose Picture", style: .default) { (action) in
            //Implement action
            self.ChoosePhoto()
        }
        
        actionSheet.addAction(cancel)
        actionSheet.addAction(takepicture)
        actionSheet.addAction(choosepicture)
        
        
        present(actionSheet, animated:true , completion:nil)
        
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
         createAlert(title: "PROCEEED?", message: "Once proceed cannot return back")
    }
    
    
    
    func TakePhoto(){
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .camera
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func ChoosePhoto(){
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func createAlert(title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //Proceed
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            //Implement action
            //alert.dismiss(animated: true, completion: nil)
            print("Proceed")
        
            
            //Proceed to the Results page 
            let Storyboard: UIStoryboard  = UIStoryboard(name: "Main", bundle: nil)
            let ResultsViewController = Storyboard.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
            self.present(ResultsViewController, animated: true, completion: nil)
            
            
            //Calling the function in RewardsViewController to pass the results
            ResultsViewController.Quiz1Question =  self.Quiz1Question
            ResultsViewController.Quiz1Useranswer =  self.Quiz1Useranswer
            ResultsViewController.Quiz1Correctanswer = self.Quiz1Correctanswer
            
        }))
        
        //Dismiss button 
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            //Implement action
            alert.dismiss(animated: true, completion: nil)
            print("Cancel")
        }))
        
        
        self.present(alert, animated: true, completion: nil)

}
    



}

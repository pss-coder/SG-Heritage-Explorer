//
//  RewardsViewController.swift
//  SG Heritage Explorer
//
//  Created by Mohamed Imran on 26/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import UIKit
import UICircularProgressRing


class RewardsViewController: UIViewController {

    //Properties
    @IBOutlet weak var UserBox: UIView!
    
    //Create UICirluar view 
    //Make it Global
    let progressRing = UICircularProgressRingView(frame: CGRect(x: 100, y: 230, width: 180, height: 180))
//    let progressRing1 = UICircularProgressRingView(frame: CGRect(x: 210, y: 250, width: 120, height: 120))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Changing the view border 
        UserBox.layer.cornerRadius = 10
        UserBox.layer.borderWidth = 1
       
        
        // Change any of the properties
        progressRing.maxValue = 100
        progressRing.value = 70
        progressRing.outerRingColor = UIColor.black
        progressRing.innerRingColor = UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0)
        self.view.addSubview(progressRing)
        
//        progressRing1.maxValue = 100
//        progressRing1.value = 70
//        progressRing1.outerRingColor = UIColor.blue
//        progressRing1.innerRingColor = UIColor.white
//        self.view.addSubview(progressRing1)

       
        animation()
        
        
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Animate the UICircular ProgressRing
    func animation () {
        
        //progressRing.setProgress(value: 49, animationDuration: 2.0) {
            print("Done animating!")
        }

    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
 
}



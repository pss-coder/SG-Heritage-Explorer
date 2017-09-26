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

    
    //Create UICirluar view 
    //Make it Global
    let progressRing = UICircularProgressRingView(frame: CGRect(x: 100, y: 100, width: 240, height: 240))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change any of the properties
        progressRing.maxValue = 100
        progressRing.value = 70
        progressRing.outerRingColor = UIColor.black
        progressRing.innerRingColor = UIColor.red
        self.view.addSubview(progressRing)
       
        animation()
        
        
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Animate the UICircular ProgressRing
    func animation () {
        
        progressRing.setProgress(value: 49, animationDuration: 2.0) {
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

}

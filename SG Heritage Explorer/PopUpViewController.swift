//
//  PopUpViewController.swift
//  SG Heritage Explorer
//
//  Created by VongolaKillerAir on 26/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var labelDisplay: UILabel!//remove this later,just for testing
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    /**
     Any tap outside of the popup view will dimiss the popup
     */
    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?) {
        let touch: UITouch? = touches.first;
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != popUpView {
            popUpView.isHidden = true
            //dismiss(animated: true, completion: nil);
        }
    }
    
    
    
    /**
    Dismiss Button action
     */
    @IBAction func dismissBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }

}

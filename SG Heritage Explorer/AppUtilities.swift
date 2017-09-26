//
//  AppUtilities.swift
//  SG Heritage Explorer
//
//  Created by VongolaKillerAir on 26/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import Foundation
import UIKit

public class AppUtilities
{
    static func showAlert(view:UIViewController,title:String,message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        view.present(alert,animated: true,completion: nil);
        
        let notification = UILocalNotification()
        notification.alertBody = "\(title) \(message)";
        notification.soundName = "Default"
        UIApplication.shared.presentLocalNotificationNow(notification)
    }

}

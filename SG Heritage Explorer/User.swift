//
//  User.swift
//  SG Heritage Explorer
//
//  Created by VongolaKillerAir on 25/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import Foundation
import UIKit

public class User
{

    var name:String
    var image:UIImage?;
    var rank:String
    var totalPoints:Int;
    var redeemablePoints:Int

    init(name:String,image:UIImage,rank:String,totalPoints:Int,redeemablePoints:Int) {
        self.name = name;
        self.image = image;
        self.rank = rank;
        self.totalPoints = totalPoints
        self.redeemablePoints = redeemablePoints;
        
    }
    
}

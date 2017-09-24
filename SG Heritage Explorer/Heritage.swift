//
//  Heritage.swift
//  SG Heritage Explorer
//
//  Created by VongolaKillerAir on 25/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import Foundation
import UIKit

/**
    In swift, use capital letters for classes and use camelcase for properties
 
 */

public class Heritage
{
    var name,description : String
    var image : UIImage?
    var location : Location;
    
    //IF LETS SAY YOUR PROPERTY IS ALLOWED TO HAVE NO VALUE (MAYBE CAUSED NOT USING IT) , USE THE OPTIONAL (?)
    //another thing to also read upon is Failable Initializer
    
    
    init(name:String,description:String,image:UIImage,location:Location) {
        self.name = name;
        self.description = description;
        self.image = image;
        self.location = location;
    }
    
    
    
}

//
//  Location.swift
//  SG Heritage Explorer
//
//  Created by VongolaKillerAir on 25/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import Foundation


public class Location
{
    
    struct Address
    {
        var name : String;
        var blockNum: String;
        var roadName : String;
        var building : String;
        

        //....
    }
    
      //let from = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 1.286789, longitude: 103.854501), name: "Merlion Park");
    var latitude:Double;
    var longtitude:Double;
    var locationAddress:Address
    
    
    init(latitude:Double,longtitude:Double,address:Address)
    {
        self.latitude = latitude;
        self.longtitude = longtitude;
        self.locationAddress = address;
    }
        
}

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
      //let from = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 1.286789, longitude: 103.854501), name: "Merlion Park");
    var latitude:Double;
    var longtitude:Double;
    
    init(latitude:Double,longtitude:Double)
    {
        self.latitude = latitude;
        self.longtitude = longtitude;
    }
        
}

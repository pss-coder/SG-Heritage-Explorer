//
//  ViewController.swift
//  SG Heritage Explorer
//
//  Created by VongolaKillerAir on 24/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController,MGLMapViewDelegate {

    
    //MARK: Properties
    @IBOutlet weak var mapView: MGLMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DisplayOneMapBaseMap();
        mapView.delegate = self;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    //MARK: PRIVATE FUNCTIONS
//================  PRIVATE FUNCTIONS  ================================
    
  
    
    /**
     Displays OneMap Base Map into Map View.
     This method also sets zoom level and displays user current location.
     - Returns: no return value
     */
    private func DisplayOneMapBaseMap()
    {
        //using onemap base map
        let styleURL = URL(string: "https://maps-json.onemap.sg/Default.json");
        mapView.styleURL = styleURL;
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // make the map resizeable
        
        //Setting the max and min of zoom level of map
        mapView.minimumZoomLevel = 10.0;
        mapView.maximumZoomLevel = 18.0;
        
        //Show User Current Locations
        mapView.showsUserLocation = true;
         mapView.setUserTrackingMode(.followWithHeading, animated: false)
        
    }
    
    
    private func LoadHeritage(){}
    
    
    
    //MARK: MAPBOX DELEGATES
//================  MAPBOX DELEGATES  ================================
    


}


//
//  LocationData.swift
//  SG Heritage Explorer
//
//  Created by Project on 25/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import Foundation
import UIKit;


public class LocationData {
    
    
    

    static func fetchPlaces( locationplace: String) {
    
   var places: [Place]? = []
    
    
    let url = URL(string: "https://developers.onemap.sg/commonapi/search?searchVal=\(locationplace)&returnGeom=Y&getAddrDetails=Y".addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!)!   //To pull data from web
    
    let task = URLSession.shared.dataTask(with: url) { (data,
        response, error) in
        
        
        
        if error != nil {
            print(error)
            return
        }
        
        places = [Place]()
        
        //codes to get specific value from the JSON
        do {
            
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
            
            if let articlesFromJson = json["results"] as? [[String : AnyObject]] {
                
                for articleFromJson in articlesFromJson {
                    let place = Place() // intance the class
                    if let locationPlace = articleFromJson["SEARCHVAL"] as? String, let lat = articleFromJson["LATITUDE"] as? String, let long = articleFromJson["LONGTITUDE"] as? String{
                        
                        place.place = locationPlace    // same name as the name in the class
                        place.lat = lat
                        place.long = long
                       
                       places?.append(place)  //pushing all the specific value from the JSON to an array
                        
                      
                    }
                    
                }
            }
           
//            DispatchQueue.main.async {
//                self.tableview.reloadData()
//            }
            
        } catch let error {
            print(error)
        }
        
        
    }
    
    task.resume()
    
    
    
}
}

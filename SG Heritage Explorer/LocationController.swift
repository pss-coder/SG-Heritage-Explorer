//
//  LocationData.swift
//  SG Heritage Explorer
//
//  Created by Project on 25/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import Foundation
import UIKit;


public class LocationController {
    
   // static var locations:[Location] = [];
    
    static func retrieveLocations(search:String){
        var locations:[Location] = [];
        
        
        let url = URL(string: "https://developers.onemap.sg/commonapi/search?searchVal=\(search)&returnGeom=Y&getAddrDetails=Y".addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!)!   //To pull data from web
        
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
          //  self.places = [Place]()
            
            //codes to get specific value from the JSON
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let articlesFromJson = json["results"] as? [[String : AnyObject]] {
                   // print(articlesFromJson)
                    
                    for articleFromJson in articlesFromJson {
                        let loc:Location;
                        
                        
                        if let _ = articleFromJson["SEARCHVAL"] as? String, let lat = articleFromJson["LATITUDE"] as? String, let long = articleFromJson["LONGTITUDE"] as? String{
                            
                            let latDouble = Double(lat);
                            let longDouble = Double(long);
                            
                            loc = Location(latitude: latDouble!, longtitude: longDouble!, address:Location.Address(name: "", blockNum: "", roadName: "", building: ""));
                            
                            locations.append(loc);
                            print("===================");
                            print(loc.latitude);
                            print("===================");
                            print(loc.longtitude);
                            print("===================");
                            print(loc.locationAddress.name);
                            print("===================");
                            //place.locationplace = places    // same name as the name in the class
                            //place.lat = lat
                            //place.long = long
                            //print(places)
                            
                            
                            
                        }
                       // return locations;
                        //self.places?.append(place)  //pushing all the specific value from the JSON to an array
                       // print(self.places)
                    }
                }
//                DispatchQueue.main.async {
//                    self.tableview.reloadData()
//                }
                
                
            } catch let error {
                print(error)
            }
            
            
        }
        
        task.resume()
        
    }

}

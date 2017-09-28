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
    
    static func retrievePlace(lat:Double, long:Double,completionHandler: @escaping (_ genres: [Location]) -> ()){
        
        var locationplace:[Location] = [];
        // array to push the selected value
        
        let url = URL(string: "https://developers.onemap.sg/privateapi/commonsvc/revgeocode?location=\(lat),\(long)&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjg3OSwidXNlcl9pZCI6ODc5LCJlbWFpbCI6Im1vaGFtZWR0YXVmaWs5ODIyQGdtYWlsLmNvbSIsImZvcmV2ZXIiOmZhbHNlLCJpc3MiOiJodHRwOlwvXC9vbTIuZGZlLm9uZW1hcC5zZ1wvYXBpXC92MlwvdXNlclwvc2Vzc2lvbiIsImlhdCI6MTUwNjU4MTg4NiwiZXhwIjoxNTA3MDEzODg2LCJuYmYiOjE1MDY1ODE4ODYsImp0aSI6ImU1NDI0NTIyNDM1MzZjYzg1NmM5N2U0NmJlMGU3ZDQzIn0.T3gMXfJ67ynjseSzOP0kRG6Yxi9OntKpG5tWYotL2_c&addressType=all".addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!)!   //To pull data from web

    
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
    
    if let articlesFromJson = json["GeocodeInfo"] as? [[String : AnyObject]] {
    // The entire JSON
     print("hello \(articlesFromJson)")
    
    for articleFromJson in articlesFromJson {
    let loc:Location;
    
    
    if let RoadName = articleFromJson["ROAD"] as? String {
    // To select the specific value
    
    
    
    
    loc = Location(latitude: 0 , longtitude: 0, address:Location.Address(name: "", blockNum: "", roadName: RoadName, building: ""));
    
    locationplace.append(loc);
    // push the selected value into the array
    completionHandler(locationplace)
//    print("===================");
//    print(loc.latitude);
//    print("===================");
//    print(loc.longtitude);
//    print("===================");
//    print(loc.locationAddress.name);
//    print("===================");
//    print("===================");
//    print(loc.locationAddress.blockNum);
//    print("===================");
//    print("===================");
//    print(loc.locationAddress.roadName);
//    print("===================");
//    print("===================");
//    print(loc.locationAddress.building);
//    print("===================");
    //place.locationplace = places    // same name as the name in the class
    //place.lat = lat
    //place.long = long
    //print(places)
    
    
    
    }
    
    }
    }
       
    
    } catch let error {
    print(error)
    }
    
    
    }
    
    task.resume()
    }
    
    
    static func retrieveLocations(search:String,completionHandler: @escaping (_ genres: [Location]) -> ()){
        var locations:[Location] = [];
        // array to push the selected value
        
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
                    // The entire JSON
                   // print(articlesFromJson)
                    
                    for articleFromJson in articlesFromJson {
                        let loc:Location;
                        
                        
                        if let placename = articleFromJson["SEARCHVAL"] as? String, let lat = articleFromJson["LATITUDE"] as? String, let long = articleFromJson["LONGTITUDE"] as? String, let BlockNum = articleFromJson["BLK_NO"] as? String,
                            let RoadNum = articleFromJson["ROAD_NAME"] as? String, let Building = articleFromJson["BUILDING"] as? String {
                            // To select the specific value
                            
                            let latDouble = Double(lat);
                            let longDouble = Double(long);
                            
                            
                            loc = Location(latitude: latDouble!, longtitude: longDouble!, address:Location.Address(name: placename, blockNum: BlockNum, roadName: RoadNum, building: Building));
                            
                            locations.append(loc);
                            // push the selected value into the array
                            completionHandler(locations)
                            print("===================");
                            print(loc.latitude);
                            print("===================");
                            print(loc.longtitude);
                            print("===================");
                            print(loc.locationAddress.name);
                            print("===================");
                            print("===================");
                            print(loc.locationAddress.blockNum);
                            print("===================");
                            print("===================");
                            print(loc.locationAddress.roadName);
                            print("===================");
                            print("===================");
                            print(loc.locationAddress.building);
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

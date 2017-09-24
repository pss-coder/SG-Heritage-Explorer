//
//  MapUtilities.swift
//  SG Heritage Explorer
//
//  Created by VongolaKillerAir on 25/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import Foundation
import Mapbox

public class MapUtilties{


    /**
     
     Method maps out a Circle using the coordinate and uses the radius as the distance from the coordinate.
     
     - Returns: MGLPolygon
     */
   static func polygonCircleForCoordinate(coordinate: CLLocationCoordinate2D, withMeterRadius: Double) -> MGLPolygon {
        let degreesBetweenPoints = 8.0
        //45 sides
        let numberOfPoints = floor(360.0 / degreesBetweenPoints)
        let distRadians: Double = withMeterRadius / 6371000.0
        // earth radius in meters
        let centerLatRadians: Double = coordinate.latitude * Double.pi / 180
        let centerLonRadians: Double = coordinate.longitude * Double.pi / 180
        var coordinates = [CLLocationCoordinate2D]()
        //array to hold all the points
        for index in 0 ..< Int(numberOfPoints) {
            let degrees: Double = Double(index) * Double(degreesBetweenPoints)
            let degreeRadians: Double = degrees * Double.pi / 180
            let pointLatRadians: Double = asin(sin(centerLatRadians) * cos(distRadians) + cos(centerLatRadians) * sin(distRadians) * cos(degreeRadians))
            let pointLonRadians: Double = centerLonRadians + atan2(sin(degreeRadians) * sin(distRadians) * cos(centerLatRadians), cos(distRadians) - sin(centerLatRadians) * sin(pointLatRadians))
            let pointLat: Double = pointLatRadians * 180 / Double.pi
            let pointLon: Double = pointLonRadians * 180 / Double.pi
            let point: CLLocationCoordinate2D = CLLocationCoordinate2DMake(pointLat, pointLon)
            coordinates.append(point)
        }
        
         return MGLPolygon(coordinates: &coordinates, count: UInt(coordinates.count))
        //self.mapView.addAnnotation(polygon)
        
    }
    
//    static func showAlert(title:String,message:String)
//    {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
//        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(action)
//        present(alert,animated: true,completion: nil); //can only be called in view controller
//        
//        
//        let notification = UILocalNotification()
//        notification.alertBody = "\(title) \(message)";
//        notification.soundName = "Default"
//        UIApplication.shared.presentLocalNotificationNow(notification)
//    }

}

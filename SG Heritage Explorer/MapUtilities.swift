//
//  MapUtilities.swift
//  SG Heritage Explorer
//
//  Created by VongolaKillerAir on 25/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import Foundation
import Mapbox
import MapboxDirections
import SwiftLocation;


public class MapUtilities{

    static var isRouteSet = 0;

    /**
     
     Method maps out a Circle using the coordinate and uses the radius as the distance from the coordinate.
     
     - Returns: MGLPolygon
     */
    static func DrawPolygonCircleForCoordinate(coordinate: CLLocationCoordinate2D, withMeterRadius: Double) -> MGLPolygon {
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
    
    
    static func Route(from:Waypoint,to:Waypoint,mapView:MGLMapView)    {
        //          let waypoints = [
        //         Waypoint(coordinate: CLLocationCoordinate2D(latitude: 1.286789, longitude: 103.854501), name: "Merlion Park"),
        //         Waypoint(coordinate: CLLocationCoordinate2D(latitude: 1.394273, longitude: 103.902965), name: "House"),
        //            ]
        let waypoints = [from,to];
        
        let options = RouteOptions(waypoints: waypoints, profileIdentifier: .automobileAvoidingTraffic)
        options.includesSteps = true
        let directions = Directions.shared;
        
        var routeLine:routePolyLine = routePolyLine();
        var routeCoordinates:[CLLocationCoordinate2D] = [];
        
        
        _ = directions.calculate(options) { (waypoints, routes, error) in
            guard error == nil else {
                print("Error calculating directions: \(error!)")
                return
            }
            
            if let route = routes?.first, let leg = route.legs.first {
                print("Route via \(leg):")
                
                let distanceFormatter = LengthFormatter()
                let formattedDistance = distanceFormatter.string(fromMeters: route.distance)
                
                let travelTimeFormatter = DateComponentsFormatter()
                travelTimeFormatter.unitsStyle = .short
                let formattedTravelTime = travelTimeFormatter.string(from: route.expectedTravelTime)
                
                print("Distance: \(formattedDistance); ETA: \(formattedTravelTime!)")
                for step in leg.steps {
                    print("\(step.instructions)")
                    let formattedDistance = distanceFormatter.string(fromMeters: step.distance)
                    print("— \(formattedDistance) —")
                }
                if route.coordinateCount > 0
                {
                    // Convert the route’s coordinates into a polyline.
                     routeCoordinates = route.coordinates!
                     routeLine = routePolyLine(coordinates: &routeCoordinates, count: route.coordinateCount)
                
                    routeLine.isRouteSet = 1;
                    
                    
                   // return routeCoordinates;
                    
                    // Add the polyline to the map and fit the viewport to the polyline.
                    isRouteSet = 1;
                    mapView.addAnnotation(routeLine)
                    mapView.setVisibleCoordinates(&routeCoordinates, count: route.coordinateCount, edgePadding: .zero, animated: true)
                   
                   
                    
                }
                //else {return nil;}
                
            }
            
        }
        //return nil;
        //routePolyLine = routeLine;
        //return (routeLine,routeCoordinates);

    }//end route method
    
    
    static func CreateGeoFence(forRegion:CLCircularRegion,onView:UIViewController,mapView:MGLMapView)
    {
        //let geofenceRegionCenter = CLLocationCoordinate2DMake(1.286789, 103.854501);
        //let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 500, identifier: "Merlion Park");
       // polygonCircleForCoordinate(coordinate: geofenceRegionCenter, withMeterRadius: 500);
        print("geofence start for \(forRegion.identifier)");
        
        do {
            //let loc = CLLocationCoordinate2DMake( 42.972474, 13.757332)
            //let radius = 100.0
            
            try SwiftLocation.Location.monitor(region: forRegion, enter: { _ in
                print("Entered in region! \(forRegion.identifier) ")
                  AppUtilities.showAlert(view:onView,title: "Entered", message: "Welcome \(forRegion.identifier)")
                displaySelectedAnnotation(mapView: mapView, annotationIdentifer: forRegion.identifier)
                
            }, exit: { _ in
                print("Exited from the region \(forRegion.identifier)")
                AppUtilities.showAlert(view:onView,title: "Exitted", message: "Bye \(forRegion.identifier)")
                
                
            }, error: { req, error in
                print("An error has occurred \(error)")
                req.cancel() // abort the request (you can also use `cancelOnError=true` to perform it automatically
            })
        } catch {
            print("Cannot start heading updates: \(error)")
        }
        
    }
    
    static func displaySelectedAnnotation(mapView:MGLMapView,annotationIdentifer:String)
    {
        //print("display \(annotation.title)");
        
        for annotation in mapView.annotations!
        {
            if annotation.title! == annotationIdentifer
            {
                mapView.selectAnnotation(annotation, animated: true);
            }
        }
    }

}

public class routePolyLine : MGLPolyline
{
     var isRouteSet:Int = 0;
}

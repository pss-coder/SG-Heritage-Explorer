//
//  ViewController.swift
//  SG Heritage Explorer
//
//  Created by VongolaKillerAir on 24/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import UIKit
import Mapbox
import MapboxDirections
import SwiftLocation
import UICircularProgressRing
import CoreLocation

class ViewController: UIViewController,MGLMapViewDelegate {

    
    //View
    @IBOutlet weak var menu: UIView!
    var menuShowing = false;
    
    //MARK: Properties
    
    private let baseMapStyle:[String] = ["Default.json","Night.json","Grey.json","Original.json"];
    private let oneMapBaseMapURL = "https://maps-json.onemap.sg/Default.json";
    @IBOutlet weak var mapView: MGLMapView!
    
    let locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DisplayOneMapBaseMap();
        mapView.delegate = self;
       
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
       // setGeoFencingFor(Heritages: LoadHeritages());
        setAnnotationsFor(Heritages: LoadHeritages());

        setGeoFencingFor(Heritages: LoadHeritages());
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    //MARK: PRIVATE FUNCTIONS
//========================================  PRIVATE FUNCTIONS  ================================
    
    /**
     Displays OneMap Base Map into Map View.
     This method also sets zoom level and displays user current location.
     - Returns: no return value
     */
    private func DisplayOneMapBaseMap()
    {
        //using onemap base map
        let styleURL = URL(string:"https://maps-json.onemap.sg/Default.json");//"\(oneMapBaseMapURL)\(baseMapStyle[0])"
       // print(oneMapBaseMapURL+baseMapStyle[0]);
        mapView.styleURL = styleURL;
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // make the map resizeable
        
        //Setting the max and min of zoom level of map
        mapView.minimumZoomLevel = 10.0;
        mapView.maximumZoomLevel = 18.0;
        
        //Show User Current Locations
        mapView.showsUserLocation = true;
         mapView.setUserTrackingMode(.followWithHeading, animated: false)
        
        let merlionParkLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(1.2867888749929002, 103.8545510172844);

       mapView.setCenter(merlionParkLocation,zoomLevel: 12, animated: false);
        
    }
    
    /**
     Method will Load Heritage from onemap API
     */
    private func LoadHeritages() -> [Heritage]
    {
        var Heritages:[Heritage] = [];
        
        let merlionPark = Heritage(name: "Merlion Park", description: "Merlion Roar",location: Location(latitude: 1.2867888749929002, longtitude: 103.8545510172844));
        
        //pointB.coordinate = CLLocationCoordinate2D(latitude: 1.394273, longitude: 103.902965)
        let PawanHome = Heritage(name: "PawanHome", description: "Pawan Roar",location: Location(latitude: 1.394273, longtitude: 103.902965));
        
        let SGBotanicGardens = Heritage(name: "Singapore Botanic Gardens", description: "Alot of flowers", location: Location(latitude: 1.313840, longtitude: 103.815914));
        let RafflesStatute = Heritage(name: "Raffles Statue", description: "White", location: Location(latitude: 1.287722, longtitude: 103.850755));
        
        Heritages.append(merlionPark);
        Heritages.append(SGBotanicGardens);
        Heritages.append(RafflesStatute);
        Heritages.append(PawanHome);
        
        return Heritages;
    }
    
    /**
     Method will take in array of heritages and display onto map as Annotations.
     */
    private func setAnnotationsFor(Heritages:[Heritage])
    {
        
        var heritageAnnotations:[HeritageAnnotation] = [];
        
        for heritage in Heritages
        {
            let annotation = HeritageAnnotation();
            annotation.coordinate = CLLocationCoordinate2D(latitude: heritage.location.latitude, longitude: heritage.location.longtitude);
            annotation.title = heritage.name;
            annotation.subtitle = heritage.description;
            annotation.willUseImage = false;
            heritageAnnotations.append(annotation);
            
        }
        mapView.addAnnotations(heritageAnnotations);
    }
    
    
    /**
     Method will Set up geofencing for each Heritage Sites
     */
    private func setGeoFencingFor(Heritages:[Heritage])
    {
        
        for heritage in Heritages
        {
            let heritageCenter = CLLocationCoordinate2DMake(heritage.location.latitude, heritage.location.longtitude);
            let polygon = MapUtilities.DrawPolygonCircleForCoordinate(coordinate: heritageCenter, withMeterRadius: 50);
            self.mapView.addAnnotation(polygon);
            
        let heritageGeoFenceRegion = CLCircularRegion(center: heritageCenter, radius: 50, identifier: heritage.name);
          MapUtilities.CreateGeoFence(forRegion: heritageGeoFenceRegion,onView: self);
           
        
        }
    }
    
    
    
    
    
//===================================  MAPBOX DELEGATES  ================================
    
        //MARK: Annotation Callout
    /** Implement the delegate method that allows annotations to show callouts when tapped.
     */
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }
    
    /**
     Delagate Method to design LEFT side of the callout annotation.
     */
    func mapView(_ mapView: MGLMapView, leftCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        if (annotation.title! == "Merlion Park") {
            // Callout height is fixed; width expands to fit its content.
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
            label.textAlignment = .right
            label.textColor = UIColor(red: 0.81, green: 0.71, blue: 0.23, alpha: 1)
            label.text = "Roar"
            return label
            
        }
        
        return nil
    }
    
    /**
     Delagate Method to design RIGHT side of the callout annotation.
     */
    func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        //PUT THE DIRECTIONS BUTTON HERE
       // return UIButton(type: .detailDisclosure)
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
      //  button.setTitle("Directions", for: .normal);
       button.setBackgroundImage(UIImage(named: "directionsIcon"), for: .normal)
        return button;
    }
    
    //DIRECTIONS  BTN CLICK
    /**
     Delagate Method to Handle when RIGHT SIDE CALLOUT IS TAPPED
     */
    func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        // Hide the callout view.
        mapView.deselectAnnotation(annotation, animated: false)
        
        // Show an alert containing the annotation's details
//        let alert = UIAlertController(title: annotation.title!!, message: "A lovely (if touristy) place.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        
        
        let from = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 1.286789, longitude: 103.854501), name: "Merlion Park");
        let to = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 1.394273, longitude: 103.902965), name: "House");
        MapUtilities.Route(from: from, to: to, mapView: mapView);
        
    }
    
    /**
     Delagate method to handle when surrounding callout is tapped.
     */
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
//        // Optionally handle taps on the callout.
//        //WHEN IMAGE OR THE CALLOUT IS TAPPED :
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "popUp") as! PopUpViewController;
//        print(annotation.title!);
//        
//        // newViewController.text = "test 123";
//        self.present(newViewController, animated: true, completion: nil)
//        newViewController.labeltest.text = annotation.title!;
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupViewController = storyBoard.instantiateViewController(withIdentifier: "popup") as! PopUpViewController;
        
      
        
        //present method must be called before setting contents
        self.present(popupViewController, animated: true, completion: nil)
          popupViewController.labelDisplay.text = annotation.title!;

        
        
        print("Tapped the callout for: \(annotation)")
        
        // Hide the callout.
     //   mapView.deselectAnnotation(annotation, animated: true)
    }
    
//  ====================================   ANNOTATION STYLE LOOK ==============================
    //MARK: Annotation Style
    
    
    
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 0.5
    }
    //    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
    //        return .white
    //    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        // Give our polyline a unique color by checking for its `title` property
        if (annotation.title == "Crema to Council Crest" && annotation is MGLPolyline) {
            // Mapbox cyan
            return UIColor(red: 59/255, green:178/255, blue:208/255, alpha:1)
        }
        else
        {
            return .red
        }
    }
    
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return UIColor(red: 59/255, green: 178/255, blue: 208/255, alpha: 1)
    }
    
    
    
    
    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        // Set the line width for polyline annotations
        return 2.0
    }
    
//    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
//        
//        if let castAnnotation = annotation as? HeritageAnnotation {
//            if (castAnnotation.willUseImage) {
//                return nil;
//            }
//        }
//        
//        // Assign a reuse identifier to be used by both of the annotation views, taking advantage of their similarities.
//        let reuseIdentifier = "reusableDotView"
//        
//        // For better performance, always try to reuse existing annotations.
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
//        
//        // If there’s no reusable annotation view available, initialize a new one.
//        if annotationView == nil {
//            annotationView = MGLAnnotationView(reuseIdentifier: reuseIdentifier)
//            annotationView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//            annotationView?.layer.cornerRadius = (annotationView?.frame.size.width)! / 2
//            annotationView?.layer.borderWidth = 4.0
//            annotationView?.layer.borderColor = UIColor.white.cgColor
//            annotationView!.backgroundColor = UIColor(red:0.03, green:0.80, blue:0.69, alpha:1.0)
//        }
//        
//        return annotationView
//    }
    

    
    // Open/Close Menu Bar
    @IBAction func menuOpen(_ sender: Any) {
        
        menuShowing = !menuShowing
        
        if(menuShowing){
            menu.isHidden = true
        }
        else{
            menu.isHidden = false
        }

    }

}

public class HeritageAnnotation:MGLPointAnnotation
{
    var willUseImage: Bool = false;
}


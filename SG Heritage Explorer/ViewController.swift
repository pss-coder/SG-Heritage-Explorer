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
import MapboxGeocoder

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
        
        //Hide the menu 
        menu.isHidden = true
        
        DisplayOneMapBaseMap();
        mapView.delegate = self;
       
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        

        setGesturesForMapView();
        setAnnotationsFor(Heritages: LoadHeritages())
        setGeoFencingFor(Heritages: LoadHeritages())
       
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    //MARK: PRIVATE FUNCTIONS
//========================================  PRIVATE FUNCTIONS  ================================
    
    /**
     Displays OneMap Base Map into Map View.
     This function also sets zoom level and displays user current location.
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
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        
       let merlionParkLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(1.2867888749929002, 103.8545510172844);
       mapView.setCenter(merlionParkLocation,zoomLevel: 12, animated: false);
        
    }
    
    /**
     Function will Load Heritage from onemap API
     */
    private func LoadHeritages() -> [Heritage]
    {
        var Heritages:[Heritage] = [];
        
        let merlionPark = Heritage(name: "Merlion Park", description: "Merlion Roar",image : (UIImage(named: "merlion"))!,location: Location(latitude: 1.2867888749929002, longtitude: 103.8545510172844,address:Location.Address(name: "", blockNum: "", roadName: "", building: "")));

        
        //pointB.coordinate = CLLocationCoordinate2D(latitude: 1.394273, longitude: 103.902965)
       // let PawanHome = Heritage(name: "PawanHome", description: "Pawan Roar",location: Location(latitude: 1.394273, longtitude: 103.902965,address:Location.Address(name: "", blockNum: "", roadName: "", building: "")));
        
        let SGBotanicGardens = Heritage(name: "Singapore Botanic Gardens", description: "Alot of flowers",image : (UIImage(named: "singaporebotanicgarden"))! ,location: Location(latitude: 1.313840, longtitude: 103.815914,address: Location.Address(name: "", blockNum: "", roadName: "", building: "")));
        let RafflesStatute = Heritage(name: "Raffles Statue", description: "White",image : (UIImage(named: "sirRaffles"))! ,location: Location(latitude: 1.287722, longtitude: 103.850755,address:Location.Address(name: "", blockNum: "", roadName: "", building: "")));
        
        Heritages.append(merlionPark);
        Heritages.append(SGBotanicGardens);
        Heritages.append(RafflesStatute);
     //   Heritages.append(PawanHome);
        
        return Heritages;
    }
    
    /**
     Function will take in array of heritages and display onto map as Annotations.
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
            annotation.Heritage = heritage;
            annotation.imageName = heritage.name;
            annotation.isNear = false;
            annotation.image = heritage.image;
            heritageAnnotations.append(annotation);
            
        }
        mapView.addAnnotations(heritageAnnotations);
    }
    
    
    /**
     Function will Set up geofencing for each Heritage Sites
     */
    private func setGeoFencingFor(Heritages:[Heritage])
    {
        
        for heritage in Heritages
        {
            let heritageCenter = CLLocationCoordinate2DMake(heritage.location.latitude, heritage.location.longtitude);
            let polygon = MapUtilities.DrawPolygonCircleForCoordinate(coordinate: heritageCenter, withMeterRadius: 50);
            self.mapView.addAnnotation(polygon);
            
        let heritageGeoFenceRegion = CLCircularRegion(center: heritageCenter, radius: 50, identifier: heritage.name);
          MapUtilities.CreateGeoFence(forRegion: heritageGeoFenceRegion,onView: self,mapView: mapView);
           
        
        }
    }
    
    /**
     Function will set Single and Long tap for mapView.
     */
    private func setGesturesForMapView()
    {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(tap:)))
        for recognizer in mapView.gestureRecognizers! where recognizer is UITapGestureRecognizer {
            singleTap.require(toFail: recognizer)
        }
        let longtap = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)));
        for longrecognizer in mapView.gestureRecognizers! where longrecognizer is UILongPressGestureRecognizer{
            longtap.require(toFail: longrecognizer);
        }
        
        mapView.addGestureRecognizer(longtap);
        mapView.addGestureRecognizer(singleTap)
    }
    
    /**
     Function takes coordinates to route user from where user specified to user destination.
     */
    private func routeUser(from:CLLocationCoordinate2D,to:CLLocationCoordinate2D)
    {
        let from = Waypoint(coordinate: CLLocationCoordinate2D(latitude: from.latitude, longitude: from.longitude), name: "Current Location")
        let to = Waypoint(coordinate: CLLocationCoordinate2D(latitude: to.latitude, longitude: to.longitude));
        MapUtilities.Route(from: from, to: to, mapView: mapView);
    }
   
    
//MARK: TAP GESTURE FUNCTIONS
//========================================  TAP GESTURES FUNCTIONS  ================================
    /**
     Handles gesture for Single Tap.When user taps on a location, will get information from onemap API to display information of tapped location.
     */
    func handleSingleTap(tap: UITapGestureRecognizer) {
        //removes the previous selected annotation if have
        for ann in mapView.annotations!
        {
            if let tappedannotation = ann as? TappedLocationAnnotation
            {
                mapView.removeAnnotation(tappedannotation);
            }
        }

        //Get tapped location coordinate
        let tapCoordinate: CLLocationCoordinate2D = mapView.convert(tap.location(in: mapView), toCoordinateFrom: mapView);
        let annotation = TappedLocationAnnotation(); //set annotation as a TappedLocationAnnotation Class
        annotation.coordinate = tapCoordinate; //set coordinate
        
        //REVERSE GEOCODE
        LocationController.retrievePlace(lat: tapCoordinate.latitude,long:tapCoordinate.longitude){
            genres in
            print("Road: \(genres.locationAddress.roadName) ")
            annotation.title = genres.locationAddress.roadName //"Latitude is : \(tapCoordinate.latitude)";
            annotation.subtitle = genres.locationAddress.blockNum //"Longtitude is : \(tapCoordinate.longitude)";
            
        }
        mapView.addAnnotation(annotation)
        
    }
    
    /**
     Handles gesture for Long Press.When long press will make tapped annotation disappear
     */
    func longPressed(sender: UILongPressGestureRecognizer)
    {
        for ann in mapView.annotations!
        {
            if let tappedannotation = ann as? TappedLocationAnnotation
            {
                mapView.removeAnnotation(tappedannotation)
                
            }
            
            
        }
    }

//===================================  MAPBOX DELEGATES  ================================
    
        //MARK: Annotation Callout
    /** 
     Implement the delegate method that allows annotations to show callouts when tapped.
     */
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        if(annotation.title == nil)
        {
            return false;
        }
        else if let heritageAnn = annotation as? HeritageAnnotation
        {
            if(!heritageAnn.isNear)//if not near
            {
                //AppUtilities.showAlert(view: self, title: "\(annotation.title)", message: "Want to get rewards ? \n Come here at \(heritageAnn.Heritage!.name)");
                return true;
            }
            else{
                return true;}
            
        }
        return true
    }
    
    /**
     Delagate Method to design LEFT side of the callout annotation.
     */
    func mapView(_ mapView: MGLMapView, leftCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
//        if (annotation.title! == "Merlion Park") {
            // Callout height is fixed; width expands to fit its content.
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
//            label.textAlignment = .right
//            label.textColor = UIColor(red: 0.81, green: 0.71, blue: 0.23, alpha: 1)
//            label.text = "Image here"
//            return label
        
//        }
//        
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
    
   
    /**
     DIRECTIONS  BTN CLICK.
     Delagate Method to Handle when RIGHT SIDE CALLOUT IS TAPPED.
     */
    func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        // Hide the callout view.
//        mapView.deselectAnnotation(annotation, animated: false)
        
        //CHECKS IF IS EITHER A HERITAGE ANNOTATION OR IS A TAPPED ANNOTATIONS TO GET DESIRED PROPERTIES FOR ROUTING
        if let selectedAnnotation = annotation as? HeritageAnnotation
        {
            let selectedCoordinate = selectedAnnotation.Heritage?.location;
            let toCoordinate = CLLocationCoordinate2D(latitude: (selectedCoordinate?.latitude)!, longitude: (selectedCoordinate?.longtitude)!);
            
            //from should either be from current location or user specified.
            let currentLocationCoordinates = mapView.userLocation?.coordinate;
            routeUser(from: currentLocationCoordinates!, to: toCoordinate);
            
        }
        else
        {
            let selectedAnnotation = annotation;
            let currentLocationCoordinates = mapView.userLocation?.coordinate;
            routeUser(from: currentLocationCoordinates!, to: selectedAnnotation.coordinate)
        }
        
            //Clear previous routing Line
            for ann in mapView.annotations!
            {
                if let routeLine = ann as? routePolyLine
                {
                    mapView.removeAnnotation(routeLine)
                    
                }
                
            }
        
    }
    
   
    
    /**
     Delagate method to handle when surrounding callout is tapped.
     */
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        
        //CHECKS IF IS A HERITAGE ANNOATTION
        if let heritageAnn = annotation as? HeritageAnnotation
        {
            if(!heritageAnn.isNear)//if user is not near the heritage , will display a popup
            {
                AppUtilities.showAlert(view: self, title: "\(annotation.title!!)", message: "Want to get rewards ? \n Come here at \(heritageAnn.Heritage!.name)");
         
            }
            else{ //else,if user is near , will display pop up
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let popupViewController = storyBoard.instantiateViewController(withIdentifier: "popup") as! PopUpViewController;
                
                //present method must be called before setting contents
                self.present(popupViewController, animated: true, completion: nil)
                
                
                //GET HERITAGE INFORMATION FROM ANNOTATION
                if let heritageAnnotation = annotation as? HeritageAnnotation
                {
                    popupViewController.labelDisplay.text = heritageAnnotation.Heritage?.name;
                    popupViewController.selectedHeritage = heritageAnnotation.Heritage!;
                }
                else
                {
                    popupViewController.labelDisplay.text = annotation.title!
                }
            }
            
        }
        
     //   mapView.deselectAnnotation(annotation, animated: true)
    }
    
//  ====================================   ANNOTATION STYLE LOOK ==============================
    //MARK: Annotation Style
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 0.5
    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
            return .red
    }
    
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return UIColor(red: 59/255, green: 178/255, blue: 208/255, alpha: 1)
    }
    
    
    
    
    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        // Set the line width for polyline annotations
        return 2.0
    }
    
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        if let point = annotation as? HeritageAnnotation {
            var image = point.image;
            image = AppUtilities.resizeImage(image: image!, targetSize:CGSize(width: 60, height: 100));
            let reuseIdentifier = point.imageName;
            if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier) {
                // The annotatation image has already been cached, just reuse it.
                return annotationImage
            } else {
                // Create a new annotation image.
                return MGLAnnotationImage(image: image!, reuseIdentifier: reuseIdentifier)
            }
        }
        
        // Fallback to the default marker image.
        return nil
    }
    
    

    
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
    var Heritage: Heritage?;
    var willUseImage: Bool = false;
    var isNear : Bool = false;
    var imageName:String = "";
    var image :UIImage?
}

public  class TappedLocationAnnotation:MGLPointAnnotation
{
}

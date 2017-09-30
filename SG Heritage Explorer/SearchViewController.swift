//
//  SearchViewController.swift
//  SG Heritage Explorer
//
//  Created by Project on 27/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var myInput: UITextField!
    
    var places: [Place]? = []
    override func viewDidLoad() {
        super.viewDidLoad()

     //   fetchPlaces();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
   //     fetchPlaces()
    }
    
    @IBAction func pressedsearched(_ sender: Any) {
        fetchPlaces()
    }
    
    
    func fetchPlaces(){
//        
//                var searchText: String
//                searchText = (myInput.text?.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed))!
//                let search:String = searchText.replacingOccurrences(of: "%20", with: " ")

        
        let url = URL(string: "https://developers.onemap.sg/commonapi/search?searchVal=merlion&returnGeom=Y&getAddrDetails=Y".addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!)!   //To pull data from web
        
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            
        
            
            
            if error != nil {
                print(error)
                return
            }
            
            self.places = [Place]()
            
            //codes to get specific value from the JSON
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let articlesFromJson = json["results"] as? [[String : AnyObject]] {
                    print(articlesFromJson)
                    for articleFromJson in articlesFromJson {
                        let place = Place() // intance the class
                        if let places = articleFromJson["SEARCHVAL"] as? String, let lat = articleFromJson["LATITUDE"] as? String, let long = articleFromJson["LONGTITUDE"] as? String{
                            
                            place.locationplace = places    // same name as the name in the class
                            place.lat = lat
                            place.long = long
                            print(places)
                        }
                        self.places?.append(place)  //pushing all the specific value from the JSON to an array
                        print(self.places)
                    }
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            
            
        }
        
        task.resume()
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceCell
       
        cell.locationplace.text = self.places?[indexPath.item].locationplace
        cell.latvalue.text = self.places?[indexPath.item].lat
        cell.longvalue.text = self.places?[indexPath.item].long

        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.places?.count ?? 0
    }

    

   
}

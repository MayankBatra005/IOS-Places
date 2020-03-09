//
//  PlaceDetailViewController.swift
//  Assignment 5
//
//  Created by Rohit  on 09/03/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import Foundation
import UIKit

class PlaceListViewController: UITableViewController {
    
    var places = Array<PlaceDescription>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadListFromSource()
    }
    
    func loadListFromSource(){
        places = PlaceLibrary.createDummyPlaceList()
        print(places.count.description)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceListIdentifier", for: indexPath)
        let place = places[indexPath.row]
        cell.textLabel?.text = place.placeName
        cell.detailTextLabel?.text = place.placeDescription
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        performSegue(withIdentifier: "PlaceDetailSegue", sender: place)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "PlaceDetailSegue"){
            let placedetailViewContoller = segue.destination as! PlaceDetailViewController
            placedetailViewContoller.place = sender as? PlaceDescription
        }
    }
    
}

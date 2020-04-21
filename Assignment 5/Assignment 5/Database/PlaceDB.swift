//
//  PlaceDB.swift
//  Assignment 5
//
//  Created by Rohit  on 20/04/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PlaceDB{
    
    var appDeledate : AppDelegate?
    var context: NSManagedObjectContext?
    
    init(){
        appDeledate = UIApplication.shared.delegate as! AppDelegate
        context = appDeledate!.persistentContainer.viewContext
    }
    
    func getAllPlacesFromDatabase(){
        
        let fetchPlacesRequest:NSFetchRequest<Place> = Place.fetchRequest()
        
        do{
            let result = try context!.fetch(fetchPlacesRequest)
             NSLog("Places loaded \(result.count)")
            
        }catch let error as NSError{
            NSLog("Error fetching places \(error)")
        }
        
    }
    
    func addPlace(place: PlaceDescription){
        let entity = NSEntityDescription.entity(forEntityName: "Place", in: context!)
        let placetable = NSManagedObject(entity: entity!, insertInto: context)
        placetable.setValue(place.placeName, forKey: "name")
        placetable.setValue(place.placeDescription, forKey: "desc")
        placetable.setValue(place.category, forKey: "category")
        placetable.setValue(place.streetTitle, forKey: "street_title")
        placetable.setValue(place.streetAddress, forKey: "street_address")
        placetable.setValue(place.elevation, forKey: "elevation")
        placetable.setValue(place.latitude, forKey: "latitude")
        placetable.setValue(place.longitude, forKey: "longitude")
    }
    
    func saveContext() -> Bool {
        var ret:Bool = false
        do{
            try context!.save()
            ret = true
        }catch let error as NSError{
            print("error saving context \(error)")
        }
        return ret
    }
}



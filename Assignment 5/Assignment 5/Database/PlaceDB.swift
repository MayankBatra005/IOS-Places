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
    
    func getAllPlacesFromDatabase(vc: UITableViewController){
        
        let fetchPlacesRequest:NSFetchRequest<Place> = Place.fetchRequest()
        var places = Array<PlaceDescription>()
        
        do{
            let results = try context!.fetch(fetchPlacesRequest)
            NSLog("Places loaded \(results.count)")
            for result in results{
//                places.append(place as! PlaceDescription)
                let place: PlaceDescription = PlaceDescription()
                place.placeName = (result as AnyObject).value(forKey:"name") as? String
                place.placeDescription = (result as AnyObject).value(forKey:"desc") as? String
                place.category = (result as AnyObject).value(forKey:"category") as? String
                place.streetTitle = (result as AnyObject).value(forKey:"street_title") as? String
                place.streetAddress = (result as AnyObject).value(forKey:"street_address") as? String
                place.elevation = (result as AnyObject).value(forKey:"elevation") as? Double
                place.latitude = (result as AnyObject).value(forKey:"latitude") as? Double
                place.longitude = (result as AnyObject).value(forKey:"longitude") as? Double
                
                places.append(place)
                
            }
            
            PlaceLibrary.allremotePlaces = places
            vc.tableView.reloadData()
             NSLog("Places loaded \(results.count)")
            
            
            
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
    
    func deletePlace(place:PlaceDescription) -> Bool {
        
        var ret:Bool = false
        let selectRequest:NSFetchRequest<Place> = Place.fetchRequest()
        selectRequest.predicate = NSPredicate(format:"name == %@",place.placeName!)
        
        do{
            let results = try context!.fetch(selectRequest)
            if results.count > 0 {
                context!.delete(results[0] as NSManagedObject)
                ret = true
            }
        } catch let error as NSError{
            NSLog("error deleting student \(place.placeName). Error \(error)")
        }
        return ret
    }
    
//    func deleteAllPlaces(){
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Place")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            var myPersistentStoreCoordinator: NSPersistentStoreCoordinator
//            try myPersistentStoreCoordinator.execute(deleteRequest, with: context)
//        } catch let error as NSError {
//            // TODO: handle the error
//        }
//    }
    
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


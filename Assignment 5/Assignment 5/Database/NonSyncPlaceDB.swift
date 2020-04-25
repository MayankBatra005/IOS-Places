//
//  NonSyncPlaceDB.swift
//  Assignment 5
//
//  Created by Rohit  on 24/04/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import Foundation
import CoreData
import UIKit

class NonSyncPlace{
    
    var appDeledate : AppDelegate?
    var context: NSManagedObjectContext?
    let DEFAULT_PLACE_NAME = "NonSyncPlacesearchPlace"
    
    init(){
        appDeledate = UIApplication.shared.delegate as! AppDelegate
        context = appDeledate!.persistentContainer.viewContext
    }
    
    public func add(name: String, action: String){
        
        let entity = NSEntityDescription.entity(forEntityName: "TempPlace", in: context!)
        let tempTable = NSManagedObject(entity: entity!, insertInto: context)
        tempTable.setValue(name, forKey: "place_name")
        tempTable.setValue(action, forKey: "sync_action")
        saveContext()
        print("Recorded action in temp data "+action+" : "+name)
    }
    
    func deleteAllPlaces(){
        
        let fetchRequest: NSFetchRequest<TempPlace>  = TempPlace.fetchRequest()
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try context!.execute(batchDeleteRequest)
            
        } catch {
            // Error Handling
        }
        
        saveContext()
        
    }
    
    public func getAllNonSyncState()->Array<PlaceDescription>{
        
        let fetchPlacesRequest:NSFetchRequest<TempPlace> = TempPlace.fetchRequest()
        var places = Array<PlaceDescription>()
        
        do{
            let results = try context!.fetch(fetchPlacesRequest)
            NSLog("Places loaded \(results.count)")
            for result in results{
                let place: PlaceDescription = PlaceDescription()
                place.placeName = (result as AnyObject).value(forKey:"place_name") as? String
                place.placeDescription = (result as AnyObject).value(forKey:"sync_action") as? String
                places.append(place)
            }
            
            NSLog("Places loaded \(results.count)")
            
        }catch let error as NSError{
            NSLog("Error fetching places \(error)")
        }
        
        
        for place in places{
            print(place.placeName!+" : "+place.placeDescription!)
        }
        
        return places
        
    }
    
    
     func pushPendingToserver(connectionCallback: ConnectionStatus){
        
        let results = getAllNonSyncState();
        
        for result in results{
            if result.placeDescription == "DELETE"{
                PlaceLibrary.deletePlaceOnServer(placeName: result.placeName!, connectionCallback: connectionCallback)
            }else if result.placeDescription == "ADD"{
                
                let targetPlace:PlaceDescription =  searchPlace(placeName: result.placeName!)
                if(targetPlace.placeName != DEFAULT_PLACE_NAME){
                    
                    print("Addding temp place "+targetPlace.placeName!)
                    
                    PlaceLibrary.addPlaceOnServer(place: targetPlace, connectionCallback: connectionCallback)
                }
                
            }
        }
        
        deleteAllPlaces()
        
        print("Finished pushing nonsync places")
        
        //connectionCallback.nonSyncPlacesPused()
        // Callback when the
    }
    
    public func searchPlace(placeName:String) -> PlaceDescription{
        
        var defaultPlace = PlaceDescription()
        defaultPlace.placeName = DEFAULT_PLACE_NAME
        
        let allPlaces = PlaceLibrary.allremotePlaces
        
        for place in allPlaces{
            if place.placeName == placeName{
                defaultPlace = place
                break;
            }
        }
        
        return defaultPlace
        
    }
    
    
    
    
    
//    public func delete(name: String) ->Bool{
//
//        var ret:Bool = false
//
//        let selectRequest:NSFetchRequest<TempPlace> = TempPlace.fetchRequest()
//        selectRequest.predicate = NSPredicate(format:"name == %@",name)
//
//        do{
//            let results = try context!.fetch(selectRequest)
//            if results.count > 0 {
//                context!.delete(results[0] as NSManagedObject)
//                ret = true
//                saveContext()
//            }
//        } catch let error as NSError{
//            NSLog("error deleting student \(name). Error \(error)")
//        }
//
//        print("Recorded delete action in temp data")
//
//        return ret
//    }
    
    
//    public func saveInRecord(name: String, action: String) ->Bool{
//
//        var ret:Bool = false
//
//        if (action == "ADD"){
//            add(name: name, action: action)
//        }else{
//
//        }
//
//        let selectRequest:NSFetchRequest<TempPlace> = TempPlace.fetchRequest()
//        selectRequest.predicate = NSPredicate(format:"name == %@",name)
//
//        do{
//            let results = try context!.fetch(selectRequest)
//            if results.count > 0 {
//                context!.delete(results[0] as NSManagedObject)
//                ret = true
//                saveContext()
//            }
//        } catch let error as NSError{
//            NSLog("error deleting student \(name). Error \(error)")
//        }
//
//        return ret
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

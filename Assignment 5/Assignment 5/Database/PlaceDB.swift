/*
 * Copyright 2020 Rohit Kumar Singh,
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @author Rohit Kumar Singh rsingh92@asu.edu
 *
 * @version April 2016
 */
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
        saveContext()
    }
    
    // Improve
    func addAllPlacesToDatabase(places: Array<PlaceDescription>){
        for place in places{
            addPlace(place: place)
        }
    }
    
    func updatePlace(oldName: String, place: PlaceDescription) {
        
        NSLog("updating place \(oldName)")
        let selectRequest:NSFetchRequest<Place> = Place.fetchRequest()
        selectRequest.predicate = NSPredicate(format:"name == %@",oldName)
        
        do{
            let results = try context!.fetch(selectRequest)
             NSLog("result \(results.count)")
            if results.count > 0 {
                let objectUpdate = results[0] as! NSManagedObject
                objectUpdate.setValue(place.placeName, forKey: "name")
                objectUpdate.setValue(place.placeDescription, forKey: "desc")
                objectUpdate.setValue(place.category, forKey: "category")
                objectUpdate.setValue(place.streetTitle, forKey: "street_title")
                objectUpdate.setValue(place.streetAddress, forKey: "street_address")
                objectUpdate.setValue(place.elevation, forKey: "elevation")
                objectUpdate.setValue(place.latitude, forKey: "latitude")
                objectUpdate.setValue(place.longitude, forKey: "longitude")
                NSLog("updating place \(place.placeName)")
                saveContext()
            }
        } catch let error as NSError{
            NSLog("error updating place \(place.placeName). Error \(error)")
        }
        
    }
    
    func deletePlace(placeName:String) -> Bool {
        
        var ret:Bool = false
        let selectRequest:NSFetchRequest<Place> = Place.fetchRequest()
        selectRequest.predicate = NSPredicate(format:"name == %@",placeName)
        
        do{
            let results = try context!.fetch(selectRequest)
            if results.count > 0 {
                context!.delete(results[0] as NSManagedObject)
                ret = true
                saveContext()
            }
        } catch let error as NSError{
            NSLog("error deleting student \(placeName). Error \(error)")
        }
        return ret
    }
    
    func deleteAllPlaces(){
        
        let fetchRequest: NSFetchRequest<Place>  = Place.fetchRequest()
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try context!.execute(batchDeleteRequest)
            
        } catch {
            // Error Handling
        }
        
        saveContext()
        print("Finished deleting all places")

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

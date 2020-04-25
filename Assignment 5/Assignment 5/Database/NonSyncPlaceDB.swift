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

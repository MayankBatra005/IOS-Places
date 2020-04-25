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
import UIKit
import CoreData

class InitialAppData{
    
    var appDeledate : AppDelegate?
    var context: NSManagedObjectContext?
    let DEFAULT_PLACE_NAME = "NonSyncPlacesearchPlace"
    
    init(){
        appDeledate = UIApplication.shared.delegate as! AppDelegate
        context = appDeledate!.persistentContainer.viewContext
    }
    
    func ifAppLaunchedFirstTime()->Bool{
        
        let fetchPlacesRequest:NSFetchRequest<AppDataInit> = AppDataInit.fetchRequest()
        var appLaunchedFirstTime = false
        
        do{
            let results = try context!.fetch(fetchPlacesRequest)
            NSLog("Data Stored loaded \(results.count)")
            for result in results{
                appLaunchedFirstTime = ((result as AnyObject).value(forKey:"first_time_launch") as? Bool)!
            }
        }catch let error as NSError{
            NSLog("Error fetching places \(error)")
        }
        
        return appLaunchedFirstTime
    }
    
    func appLoaded(){
        let entity = NSEntityDescription.entity(forEntityName: "AppDataInit", in: context!)
        let table = NSManagedObject(entity: entity!, insertInto: context)
        table.setValue(true, forKey: "first_time_launch")
        saveContext()
    }
    
    func getInitailData()->PlaceDescription{
        let place: PlaceDescription = PlaceDescription()
        place.placeName = "ASU-Poly"
        place.placeDescription = "Home of ASUs Software Engineering Programs"
        place.category = "School"
        place.streetTitle = "ASU Software Engineering"
        place.streetAddress = "7171 E Sonoran Arroyo Mall$Peralta Hall 230$Mesa AZ 85212"
        place.elevation = 1300
        place.latitude = 33.306388
        place.longitude = -111.679121
        return place
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

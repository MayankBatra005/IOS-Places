//
//  InitialAppData.swift
//  Assignment 5
//
//  Created by Rohit  on 25/04/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

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
        place.placeDescription = "kajsa"
        place.category = "School"
        place.streetTitle = "sssd"
        place.streetAddress = "dsds"
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

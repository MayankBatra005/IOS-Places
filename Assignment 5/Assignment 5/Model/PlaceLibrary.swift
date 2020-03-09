//
//  PlaceLibrary.swift
//  Assignment 5
//
//  Created by Rohit  on 09/03/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import Foundation

class PlaceLibrary{
    
    static func createDummyPlaceList() -> Array<PlaceDescription> {
        
        var places = Array<PlaceDescription>()
        
        
        for i in 1...10 {
            let place = PlaceDescription(placeName: "Rohit"+i.description)
            places.append(place)
        }
        
        return places
    }
    
}

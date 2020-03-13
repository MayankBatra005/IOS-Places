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
            let place = PlaceDescription(placeName: "Place "+i.description)
            place.placeDescription = "Desc "+i.description
            place.category = "Category "+i.description
            place.streetAddress = "StreetAddress "+i.description
            place.streetTitle = "Street Title "+i.description
            place.elevation = Double(10+i);
            place.latitude = Double(233+i)
            place.longitude = Double(100+i)
            places.append(place)
        }
        
        return places
    }
    
}

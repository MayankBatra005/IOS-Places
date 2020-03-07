//
//  PlaceLibrary.swift
//  Places
//
//  Created by Rohit  on 07/03/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import Foundation

class PlaceLibrary{
    
    
    func getDummyPlaces() ->Array<PlaceDescription>{
        
        var places = Array<PlaceDescription>()
        let dummyPlace = PlaceDescription()
        dummyPlace.placeName = "Delhi"
        dummyPlace.category = "Hike"
        dummyPlace.addressStreet = "1718 S, Jentily lane"
        dummyPlace.addressTitle = "Agave"
        dummyPlace.descripion = "Best place to hike"
        dummyPlace.elevation = 10.878
        dummyPlace.longitude = 98.33
        dummyPlace.latitude = 21.66
        
        places.append(dummyPlace)
        places.append(dummyPlace)
        places.append(dummyPlace)
        places.append(dummyPlace)
        places.append(dummyPlace)
        places.append(dummyPlace)
        
        return places
    }
    
}

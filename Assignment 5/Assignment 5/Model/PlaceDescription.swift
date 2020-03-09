//
//  PlaceDescription.swift
//  Assignment 5
//
//  Created by Rohit  on 09/03/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import Foundation

class PlaceDescription {
    
    var placeName: String?
    var placeDescription: String?
    var category: String?
    var streetTitle: String?
    var streetAddress: String?
    var elevation: Double?
    var latitude: Double?
    var longitude: Double?
    
    
    init() {
        
    }
    
    init(placeName: String) {
        self.placeName = placeName
    }
}

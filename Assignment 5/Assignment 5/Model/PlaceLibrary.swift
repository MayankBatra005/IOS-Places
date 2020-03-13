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
 * @version March 2016
 */


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

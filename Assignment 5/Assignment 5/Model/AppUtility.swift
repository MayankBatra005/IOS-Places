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

class AppUtility{
    
    static func getDistance(currentPlace:PlaceDescription, selectedPlace: PlaceDescription) -> Double {
        
        var lat1 = 0.0
        var lat2 = 0.0
        var lon1 = 0.0
        var lon2 = 0.0
        
        lat1 = currentPlace.latitude ?? 0.0
        lon1 = currentPlace.longitude ?? 0.0
        
        lat2 = selectedPlace.latitude ?? 0.0
        lon2 = selectedPlace.longitude ?? 0.0
        
        if ((lat1 == lat2) && (lon1 == lon2)) {
            return 0.00
        } else {
            let theta = lon1 - lon2
            var dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2))
                + cos(deg2rad(lat1)) * cos(deg2rad(lat2))
                * cos(deg2rad(theta))
            dist = acos(dist)
            dist = radiansToDegrees(radians: dist)
            dist = dist * 60 * 1.1515 * 1.609344
            return (dist)
        }
    }
    
    static func getBearing(currentPlace:PlaceDescription, selectedPlace: PlaceDescription) -> Double {
        
        var lat1 = 0.0
        var lat2 = 0.0
        var lon1 = 0.0
        var lon2 = 0.0
        
        lat1 = currentPlace.latitude ?? 0.0
        lat1 = deg2rad(lat1)
        
        lon1 = currentPlace.longitude ?? 0.0
        
        lat2 = selectedPlace.latitude ?? 0.0
        lat2 = deg2rad(lat2)
        
        lon2 = selectedPlace.longitude ?? 0.0
        
        let longDiff = deg2rad(lon2 - lon1)
        let y = sin(longDiff) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(longDiff)
        
        return (radiansToDegrees(radians: atan2(y, x)) + 360).truncatingRemainder(dividingBy:360)
    }
    
    static func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    static func radiansToDegrees (radians: Double)->Double {
        return radians * 180 / .pi
    }
    
}

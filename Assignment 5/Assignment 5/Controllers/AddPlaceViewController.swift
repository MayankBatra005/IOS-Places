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

import UIKit

class AddPlaceViewController: UIViewController, DialogCallBack {
    
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeDescription: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var streetTitle: UITextField!
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var elevation: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    
    var currentPlace = PlaceDescription()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func clickMe(_ sender: Any) {
        print("This click")
    }
    
    @IBAction func savePlace(_ sender: Any) {
        Alert.savePlaceAlert(on: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="SaveAddPlace"){
            
            let placeListVC = segue.destination as! PlaceListViewController
            placeListVC.modifiedPlace = sender as! PlaceDescription
        }
    }
    
    func getCurrentPlaceFromUI() -> PlaceDescription {
        currentPlace.placeName = placeName.text
        currentPlace.placeDescription = placeDescription.text
        currentPlace.category = category.text
        currentPlace.streetTitle = streetTitle.text
        currentPlace.streetAddress = streetAddress.text
        currentPlace.elevation = Double(elevation.text ?? "")
        currentPlace.latitude = Double(latitude.text ?? "")
        currentPlace.longitude = Double(longitude.text ?? "")
        return currentPlace
    }
    
    func okButtonCliked() {
        performSegue(withIdentifier: "SaveAddPlace", sender: getCurrentPlaceFromUI())
    }
    
}

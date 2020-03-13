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
import UIKit

struct Alert{
    
    private static func createBasicAlert(on vc:UIViewController, title: String, message: String){
        
        let deleteAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let dialogController = vc as! DialogCallBack
        deleteAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in dialogController.okButtonCliked()}))
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {(action) in deleteAlert.dismiss(animated: true, completion: nil)}))
        
        vc.present(deleteAlert, animated: true, completion: nil)
        
    }
    
    static func deletePlaceAlert(on vc: UIViewController){
        createBasicAlert(on: vc, title: "Delete Place", message: "Do you want to delete this place?")
    }
    
    static func savePlaceAlert(on vc: UIViewController){
        createBasicAlert(on: vc, title: "Save Place", message: "Do you want to save this place?")
    }
    
    static func editPlaceAlet(on vc: UIViewController){
        createBasicAlert(on: vc, title: "Edit place", message: "Do you want to modify the place information")
    }
    
}


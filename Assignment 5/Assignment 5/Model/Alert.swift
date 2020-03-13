//
//  Alert.swift
//  Assignment 5
//
//  Created by Rohit  on 10/03/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

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
        createBasicAlert(on: vc, title: "Delete Place", message: "Do you really want to delete this place")
    }
    
}

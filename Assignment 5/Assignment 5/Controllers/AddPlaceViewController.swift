//
//  AddPlaceViewController.swift
//  Assignment 5
//
//  Created by Rohit  on 11/03/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import UIKit

class AddPlaceViewController: UIViewController {
    
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
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickMe(_ sender: Any) {
        print("This click")
    }
    
    @IBAction func savePlace(_ sender: Any) {
        performSegue(withIdentifier: "SaveAddPlace", sender: getCurrentPlaceFromUI())
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
    
}

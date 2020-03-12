//
//  AddPlaceViewController.swift
//  Assignment 5
//
//  Created by Rohit  on 11/03/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import UIKit

class AddPlaceViewController: UIViewController {
    
    var currentPlace = PlaceDescription()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickMe(_ sender: Any) {
        print("This click")
    }
    
    @IBAction func savePlace(_ sender: Any) {
        performSegue(withIdentifier: "SaveAddPlace", sender: getCurrentPlace())
        print("This is Menu item")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="SaveAddPlace"){
            
            let placeListVC = segue.destination as! PlaceListViewController
            placeListVC.modifiedPlace = sender as! PlaceDescription
        }
    }
    
    func getCurrentPlace() -> PlaceDescription {
        currentPlace.placeName = "Delhi"
        return currentPlace
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

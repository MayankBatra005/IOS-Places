//
//  ViewController.swift
//  Assignment 5
//
//  Created by Rohit  on 09/03/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import UIKit

class PlaceDetailViewController: UIViewController {
    
    @IBOutlet weak var placeName: UITextView!
    @IBOutlet weak var placeDescription: UITextView!
    @IBOutlet weak var category: UITextView!
    @IBOutlet weak var streetTitle: UITextView!
    @IBOutlet weak var streetAddress: UITextView!
    @IBOutlet weak var elevation: UITextView!
    @IBOutlet weak var longitude: UITextView!
    @IBOutlet weak var latitude: UITextView!
    
    var currentPlace: PlaceDescription?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Inside")
        setUpUI()
    }
    
    func setUpUI(){
        placeName.text = currentPlace?.placeName
        placeDescription.text = currentPlace?.placeDescription
        category.text = currentPlace?.category
        streetTitle.text = currentPlace?.streetTitle
        streetAddress.text = currentPlace?.streetAddress
        elevation.text = currentPlace?.elevation?.description
        latitude.text = currentPlace?.latitude?.description
        longitude.text = currentPlace?.longitude?.description
    }
    
    
    @IBAction func onDeleteClicked(_ sender: Any) {
        
        showDeleteAlert(title: "Delete", message: "Do you really want to delete this place?")
    }
    
    @IBAction func modifyPlace(_ sender: Any) {
        performSegue(withIdentifier: "modifyPlace", sender: getPlaceFromUI())
    }
    
    func showDeleteAlert(title: String, message: String){
        
        Alert.deletePlaceAlert(on: self)
//        deletethePlace()
    }
    
    func deletethePlace(){
        
        performSegue(withIdentifier: "gobacktoPlaceList", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="modifyPlace"){
            let placeDetailVC = segue.destination as! PlaceListViewController
            placeDetailVC.modifiedPlace = sender as! PlaceDescription
        }
    }
    
    func getPlaceFromUI() -> PlaceDescription{
        currentPlace?.placeName = placeName.text
        currentPlace?.placeDescription = placeDescription.text
        currentPlace?.category = category.text
        currentPlace?.streetTitle = streetTitle.text
        currentPlace?.streetAddress = streetAddress.text
        currentPlace?.elevation = Double(elevation.text)
        currentPlace?.latitude = Double(latitude.text)
        currentPlace?.longitude = Double(longitude.text)
        
        return currentPlace ?? PlaceDescription()
    }
}


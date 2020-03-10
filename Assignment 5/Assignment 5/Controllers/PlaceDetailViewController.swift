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
    
    var place: PlaceDescription?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Inside")
        setUpUI()
    }
    
    func setUpUI(){
        placeName.text = place?.placeName
    }
    
    
    @IBAction func onDeleteClicked(_ sender: Any) {
        
        showDeleteAlert(title: "Delete", message: "Do you really want to delete this place?")
    }
    
    
    
    func showDeleteAlert(title: String, message: String){
        
        let deleteAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        deleteAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in deleteAlert.dismiss(animated: true, completion: nil)}))
        
        self.present(deleteAlert, animated: true, completion: nil)
    }

}


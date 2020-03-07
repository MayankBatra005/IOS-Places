//
//  ViewController.swift
//  Places
//
//  Created by Rohit  on 26/02/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import UIKit

class PlaceDetailViewController: UIViewController {

    
    @IBOutlet weak var placeName: UILabel!
    
    @IBOutlet weak var placeDescription: UILabel!
    
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var addressTitle: UILabel!
    
    @IBOutlet weak var addressStreet: UILabel!
    
    @IBOutlet weak var elevation: UILabel!
    
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var longitude: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}


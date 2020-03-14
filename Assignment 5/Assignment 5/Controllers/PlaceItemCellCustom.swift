//
//  PlaceItemCellCustomTableViewCell.swift
//  Assignment 5
//
//  Created by Rohit  on 13/03/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import UIKit

class PlaceItemCellCustom: UITableViewCell {
    
    
    @IBOutlet weak var placeFace: UILabel!
    
    @IBOutlet weak var placeName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setView(place:PlaceDescription){
        let pname = place.placeName
        placeName.text = pname
//        placeFace.text = getFaceValue(name: pname ?? " ")
    }
    
    private func getFaceValue(name:String) -> String{
        let firstChar = Array(name)[0]
        return firstChar.description
    }
    
    
}

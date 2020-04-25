//
//  ConnectionStatus.swift
//  Assignment 5
//
//  Created by Rohit  on 22/04/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import Foundation

protocol ConnectionStatus {
    func connectionFailed(placeName:String, actionName: String)
    func nonSyncPlacesPused();
}

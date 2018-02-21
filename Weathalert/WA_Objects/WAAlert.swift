//
//  WAAlert.swift
//  Weathalert
//
//  Created by Scott Browne on 03/01/2018.
//  Copyright © 2018 Smiles Dev. All rights reserved.
//

import UIKit

class WAAlert: NSObject, Codable {
    
    var weatherOfNote: [String]
    var daysOfInterest: [Int]
    var daysNotice: Int
    var lastUpdated: Int?
    
    init(weatherOfNote: [String], daysOfInterest: [Int], daysNotice: Int){
        self.weatherOfNote = weatherOfNote
        self.daysOfInterest = daysOfInterest
        self.daysNotice = daysNotice
    }
    
}

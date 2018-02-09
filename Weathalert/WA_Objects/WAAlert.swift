//
//  WAAlert.swift
//  Weathalert
//
//  Created by Scott Browne on 03/01/2018.
//  Copyright © 2018 Smiles Dev. All rights reserved.
//

import UIKit

class WAAlert: NSObject, NSCoding {
    
    var weatherOfNote: [Int]
    var daysOfInterest: [Int]
    var daysNotice: Int
    var lastUpdated: Int?
    
    init(weatherOfNote: [Int], daysOfInterest: [Int], daysNotice: Int){
        self.weatherOfNote = weatherOfNote
        self.daysOfInterest = daysOfInterest
        self.daysNotice = daysNotice
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let lastUpdated = aDecoder.decodeObject(forKey: "LastUpdated") as? Int else { return nil }
        
        self.init(weatherOfNote: aDecoder.decodeObject(forKey: "Name") as! [Int],
                  daysOfInterest: aDecoder.decodeObject(forKey: "Long") as! [Int],
                  daysNotice: aDecoder.decodeObject(forKey: "Lat") as! Int)
        
        self.lastUpdated = lastUpdated
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.weatherOfNote, forKey: "WeatherOfNote")
        aCoder.encode(self.daysOfInterest, forKey: "DaysOfInterest")
        aCoder.encode(self.daysNotice, forKey: "DaysNotice")
        
        aCoder.encode(self.lastUpdated, forKey: "LastUpdated")
    }
    
    
}

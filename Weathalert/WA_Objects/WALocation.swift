//
//  WALocation.swift
//  Weathalert
//
//  Created by Scott Browne on 03/01/2018.
//  Copyright © 2018 Smiles Dev. All rights reserved.
//

import Foundation
import UIKit

class WALocation: NSObject, NSCoding {
    
    var locName: String
    var locLong: Double
    var locLat: Double
    var alerts: [WAAlert]?
    var forecasts: [WAForecast]?
    
    init(locName: String, locLong: Double, locLat: Double){
        self.locName = locName
        self.locLong = locLong
        self.locLat = locLat
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let alerts = aDecoder.decodeObject(forKey: "Alerts") as? [WAAlert] else { return nil }
        guard let forecasts = aDecoder.decodeObject(forKey: "Forecasts") as? [WAForecast] else { return nil }
        
        self.init(locName: aDecoder.decodeObject(forKey: "Name") as! String,
                    locLong: aDecoder.decodeObject(forKey: "Long") as! Double,
                    locLat: aDecoder.decodeObject(forKey: "Lat") as! Double)
        
        self.alerts = alerts
        self.forecasts = forecasts
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.locName, forKey: "Name")
        aCoder.encode(self.locLong, forKey: "Long")
        aCoder.encode(self.locLat, forKey: "Lat")
        
        aCoder.encode(self.alerts, forKey: "Alerts")
        aCoder.encode(self.forecasts, forKey: "Forecasts")
        
        print("DUM DUM DUM")
    }
    
}

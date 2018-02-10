//
//  WAForecast.swift
//  Weathalert
//
//  Created by Scott Browne on 07/02/2018.
//  Copyright © 2018 Smiles Dev. All rights reserved.
//

import UIKit

class WAForecast: NSObject, NSCoding {
    
    var time: Int
    var icon: String
    var tempHigh: Double?
    var tempLow: Double?
    var windSpeed: Float?
    var windBearing: Int?
    var precipIntensityMax: Double?
    var precipProbability: Double?
    
    init(time: Int, icon: String) {
        self.time = time
        self.icon = icon
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let tempHigh = aDecoder.decodeObject(forKey: "TempHigh") as? Double else { return nil }
        guard let tempLow = aDecoder.decodeObject(forKey: "TempLow") as? Double else { return nil }
        guard let windSpeed = aDecoder.decodeObject(forKey: "WindSpeed") as? Float else { return nil }
        guard let windBearing = aDecoder.decodeObject(forKey: "WindBearing") as? Int else { return nil }
        guard let precipIntensityMax = aDecoder.decodeObject(forKey: "PrecipIntensity") as? Double else { return nil }
        guard let precipProbability = aDecoder.decodeObject(forKey: "PrecipProb") as? Double else { return nil }
        
        self.init(time: aDecoder.decodeObject(forKey: "Time") as! Int,
                  icon: aDecoder.decodeObject(forKey: "Icon") as! String)
        
        self.tempHigh = tempHigh
        self.tempLow = tempLow
        self.windSpeed = windSpeed
        self.windBearing = windBearing
        self.precipIntensityMax = precipIntensityMax
        self.precipProbability = precipProbability
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.time, forKey: "Time")
        aCoder.encode(self.icon, forKey: "Icon")
        
        aCoder.encode(self.tempHigh, forKey: "TempHigh")
        aCoder.encode(self.tempLow, forKey: "TempLow")
        aCoder.encode(self.windSpeed, forKey: "WindSpeed")
        aCoder.encode(self.windBearing, forKey: "WindBearing")
        aCoder.encode(self.precipIntensityMax, forKey: "PrecipIntensity")
        aCoder.encode(self.precipProbability, forKey: "PrecipProb")
    }
    
}

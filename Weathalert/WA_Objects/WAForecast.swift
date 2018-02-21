//
//  WAForecast.swift
//  Weathalert
//
//  Created by Scott Browne on 07/02/2018.
//  Copyright © 2018 Smiles Dev. All rights reserved.
//

import UIKit

class WAForecast: NSObject, Codable {
    
    var time: Double
    var icon: String
    var tempHigh: Double?
    var tempLow: Double?
    var windSpeed: Float?
    var windBearing: Int?
    var precipIntensityMax: Double?
    var precipProbability: Double?
    
    init(time: Double, icon: String) {
        self.time = time
        self.icon = icon
    }
    
}

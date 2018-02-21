//
//  WALocation.swift
//  Weathalert
//
//  Created by Scott Browne on 03/01/2018.
//  Copyright © 2018 Smiles Dev. All rights reserved.
//

import Foundation
import UIKit

struct DarkSkyForecastJSON: Codable {
    
    var timezone: String
    var daily: week
    
    struct week: Codable {
        
        var data: [day]
    
        struct day: Codable {
            
            var time: Double
            var icon: String
            var temperatureHigh: Double
            var temperatureLow: Double
            var windSpeed: Float
            var windBearing: Int
            var precipIntensityMax: Double
            var precipProbability: Double
            
        }
    }
}

class WALocation: NSObject, Codable {
    
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
    
    func getForecast(){
        
        let urlString = "https://api.darksky.net/forecast/715f563c9b34d1202cd577879fe0720a/"+String(locLat)+","+String(locLong)
        //let bodyString = "exclude=[currently,minutely,hourly,flags]"
        
        print(urlString)
        //print(bodyString)
        
        let jsonURL = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: jsonURL as URL!)
        let session = URLSession.shared
        request.httpMethod = "GET"
        //request.httpBody = bodyString.data(using: String.Encoding.utf8)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else { return }
            
//            let backToString = String(data: data, encoding: String.Encoding.utf8) as String!
//            print(backToString as String!)
            
            do{
                let info = try JSONDecoder().decode(DarkSkyForecastJSON.self, from: data)

                var forecastArray = [WAForecast]()
                
                for day in info.daily.data {
                    
                    let forecastObject = WAForecast.init(time: day.time, icon: day.icon)

                    forecastObject.tempHigh = day.temperatureHigh
                    forecastObject.tempLow = day.temperatureLow
                    forecastObject.windSpeed = day.windSpeed
                    forecastObject.windBearing = day.windBearing
                    forecastObject.precipIntensityMax = day.precipIntensityMax
                    forecastObject.precipProbability = day.precipProbability
                    
                    forecastArray.append(forecastObject)
                    
                }
                
                self.forecasts = forecastArray

            } catch let jsonErr {
                    print("Error parsing JSON:", jsonErr)
            }
            
        }.resume()
    }
    
}

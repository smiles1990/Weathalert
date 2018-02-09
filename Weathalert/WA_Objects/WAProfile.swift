//
//  WAProfile.swift
//  Weathalert
//
//  Created by Scott Browne on 09/01/2018.
//  Copyright © 2018 Smiles Dev. All rights reserved.
//

import Foundation
import UIKit

class WAProfile: NSObject, NSCoding {
    
    var profileName: String!
    var profileLocations = [WALocation]()
    
    init(profileName: String) {
        self.profileName = profileName
    }
    
    required convenience init?(coder aDecoder: NSCoder) {

        guard let locations = aDecoder.decodeObject(forKey: "Locations") as? [WALocation] else { return nil }

        for loc in locations {

            print(loc.locName)

        }

        self.init( profileName: aDecoder.decodeObject(forKey: "Name") as! String)
        self.profileLocations = locations
        print(profileLocations.count)

    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.profileName, forKey: "Name")
        aCoder.encode(self.profileLocations, forKey: "Locations")
    }
    
}

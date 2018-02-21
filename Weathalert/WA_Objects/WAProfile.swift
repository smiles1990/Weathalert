//
//  WAProfile.swift
//  Weathalert
//
//  Created by Scott Browne on 09/01/2018.
//  Copyright © 2018 Smiles Dev. All rights reserved.
//

import Foundation
import UIKit

class WAProfile: NSObject, Codable {
    
    var profileName: String!
    var profileLocations = [WALocation]()
    
    init(profileName: String, profileLocations: [WALocation]) {
        self.profileName = profileName
        self.profileLocations = profileLocations
    }
    
}

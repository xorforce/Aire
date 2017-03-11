//
//  Location.swift
//  Aire
//
//  Created by Bhagat Singh on 3/10/17.
//  Copyright © 2017 com.bhagat_singh. All rights reserved.
//

import Foundation
import UIKit

class Location{
    static var sharedInstance = Location()
    private init() {}
    
    var latitude : Double!
    var longitude : Double!
}

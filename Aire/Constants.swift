//
//  Constants.swift
//  Aire
//
//  Created by Bhagat Singh on 3/10/17.
//  Copyright © 2017 com.bhagat_singh. All rights reserved.
//

import Foundation


let latitude = Location.sharedInstance.latitude!
let longitude = Location.sharedInstance.longitude!
let apiKey = "YOUR-API-KEY-HERE"


let apiUrl = "http://api.airvisual.com//v2/nearest_city?lat=\(latitude)&lon=\(longitude)&rad=1000&key=\(apiKey)"



typealias completed = () -> ()
ter

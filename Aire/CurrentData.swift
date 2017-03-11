//
//  currentData.swift
//  Aire
//
//  Created by Bhagat Singh on 3/10/17.
//  Copyright © 2017 com.bhagat_singh. All rights reserved.
//

import Foundation
import Alamofire

class CurrentData{
    
    var _city : String!
    var _aqi : Int!
    
    var city : String{
        if _city == nil{
            return ""
        }
        return _city
    }
    
    var aqi : Int{
        if _aqi == nil{
            return 0
        }
        return _aqi
    }
    
    func downloadDetails(completed: @escaping completed){
        Alamofire.request(apiUrl, method: .get).responseJSON { (response) in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let data = dict["data"] as? Dictionary<String,AnyObject>{
                    
                    if let city = data["city"] as? String{
                        self._city = city
                    }
                    
                    if let current = data["current"] as? Dictionary<String,AnyObject>{
                        if let pollution = current["pollution"] as? Dictionary<String,AnyObject>{
                            
                            if let aqi = pollution["aqius"] as? Int{
                                self._aqi = aqi
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
    
}

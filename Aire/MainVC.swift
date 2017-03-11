//
//  MainVC.swift
//  Aire
//
//  Created by Bhagat Singh on 3/10/17.
//  Copyright © 2017 com.bhagat_singh. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class MainVC: UIViewController,CLLocationManagerDelegate{

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var line3: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
   
    let maroon = UIColor(red: 137/255, green: 26/255, blue: 28/255, alpha: 1.0)
    let green  = UIColor(red: 165/255, green: 205/255, blue: 57/255, alpha: 1.0)
    let yellow = UIColor(red: 255/255, green: 242/255, blue: 0/255, alpha: 1.0)
    let orange = UIColor(red: 247/255, green: 144/255, blue: 30/255, alpha: 1.0)
    let red    = UIColor(red: 237/255, green: 29/255, blue: 36/255, alpha: 1.0)
    let purple = UIColor(red: 160/255, green: 6/255, blue: 73/255, alpha: 1.0)
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    var currentData : CurrentData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstUI()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        currentData = CurrentData()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus()
    }
    
    func locationStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentData.downloadDetails {
                self.updateMainUI()
            }
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func aqiIndex(aqi: Int){
        
        switch(aqi){
        case 0..<50:
            healthLabel.text = "Good"
            self.view.backgroundColor = green
            image1.image = UIImage(named: "swings")
            line1.text = "The air is pure. Take a stroll in the park."
            line1.textColor = UIColor.darkGray
            image2.image = UIImage(named: "ice-cream")
            line2.text = "Have some ice cream with your family"
            line2.textColor = UIColor.darkGray
            image3.image = UIImage(named: "forbidden")
            line3.text = "You have nothing to worry about!"
            line3.textColor = UIColor.darkGray
            
            
        case 50..<100:
            healthLabel.text = "Moderate"
            self.view.backgroundColor = yellow
            image1.image = UIImage(named: "swings")
            line1.text = "The air is pure. Take a stroll in the park."
            line1.textColor = UIColor.darkGray
            image2.image = UIImage(named: "ice-cream")
            line2.text = "Have some ice cream with your family"
            line2.textColor = UIColor.darkGray
            image3.image = UIImage(named: "forbidden")
            line3.text = "You have nothing to worry about!"
            line3.textColor = UIColor.darkGray
            
        case 101..<150:
            healthLabel.text = "Unhealthy"
            self.view.backgroundColor = orange
            image1.image = UIImage(named: "lungs")
            line1.text = "Asthmatic patients should stay inside."
            line1.textColor = UIColor.darkGray
            image2.image = UIImage(named: "medical-mask")
            line2.text = "Wear a mask if possible."
            line2.textColor = UIColor.darkGray
            image3.image = UIImage(named: "home")
            line3.text = "Try to stay indoors."
            line3.textColor = UIColor.darkGray
            
        case 150..<200:
            healthLabel.text = "Unhealthy"
            self.view.backgroundColor = red
            image1.image = UIImage(named: "medical-mask")
            line1.text = "Wearing a mask is recommended."
            line1.textColor = UIColor.white
            image2.image = UIImage(named: "home")
            line2.text = "Stay indoors if possible."
            line1.textColor = UIColor.white
            image3.image = UIImage(named: "hospital")
            line3.text = "Long term exposure may cause health degradation."
            line1.textColor = UIColor.white
            
        case 200..<250:
            healthLabel.text = "Very Unhealthy"
            self.view.backgroundColor = maroon
            image1.image = UIImage(named: "medical-mask")
            line1.text = "Wearing a mask is recommended."
            image2.image = UIImage(named: "home")
            line2.text = "Stay indoors if possible."
            image3.image = UIImage(named: "hospital")
            line3.text = "Long term exposure may cause health degradation."
            line1.textColor = UIColor.white
            line2.textColor = UIColor.white
            line3.textColor = UIColor.white
            
        case 250..<5000:
            healthLabel.text = "Hazardous"
            self.view.backgroundColor = purple
            image1.image = UIImage(named: "prohibited")
            line1.text = "Recommended that you don't go out."
            image2.image = UIImage(named: "home")
            line2.text = "Stay indoors if possible."
            image3.image = UIImage(named: "lungs")
            line3.text = "Long term exposure may cause lung diseases."
            line1.textColor = UIColor.white
            line2.textColor = UIColor.white
            line3.textColor = UIColor.white
            
        default:
            healthLabel.text = "Moderate"
            self.view.backgroundColor = yellow
            image1.image = UIImage(named: "swings")
            line1.text = "The air is pure. Take a stroll in the park."
            image2.image = UIImage(named: "ice-cream")
            line2.text = "Have some ice cream with your family"
            image3.image = UIImage(named: "forbidden")
            line3.text = "You have nothing to worry about!"
            line1.textColor = UIColor.darkGray
            line2.textColor = UIColor.darkGray
            line3.textColor = UIColor.darkGray
        }
    }
    
    func updateMainUI(){
        cityLabel.text = currentData.city
        aqiLabel.text = "\(currentData.aqi)"
        aqiIndex(aqi: currentData.aqi)
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        cityLabel.alpha = 1.0
        aqiLabel.alpha = 1.0
        healthLabel.alpha = 1.0
        image1.alpha = 1.0
        image2.alpha = 1.0
        image3.alpha = 1.0
        line1.alpha = 1.0
        line2.alpha = 1.0
        line3.alpha = 1.0
        locationImage.alpha = 1.0
    }
    
    func firstUI(){
        activityIndicator.startAnimating()
        mainView.layer.cornerRadius = 7.0
        self.view.backgroundColor = UIColor.white
        cityLabel.alpha = 0.0
        aqiLabel.alpha = 0.0
        healthLabel.alpha = 0.0
        image1.alpha = 0.0
        image2.alpha = 0.0
        image3.alpha = 0.0
        line1.alpha = 0.0
        line2.alpha = 0.0
        line3.alpha = 0.0
        locationImage.alpha = 0.0
    
    }
    
}


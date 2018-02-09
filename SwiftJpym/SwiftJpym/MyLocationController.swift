//
//  MyLocationController.swift
//  SwiftJpym
//
//  Created by admin on 2017/9/19.
//  Copyright © 2017年 liushuang.library. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MyLocationController: UIViewController {
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MyLocationController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print(region)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placeMark, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            }else{
                if placeMark!.count > 0 {
                    let pm = placeMark![0]
                    self.displayLocationInfo(pm)
                    
                }else{
                    print("error")
                }
            }
        }
    }
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            
            print(postalCode! + " " + locality!)
            var str = ""
            print(str.append("\n" + administrativeArea! + ", " + country!))
        }
        
    }
}

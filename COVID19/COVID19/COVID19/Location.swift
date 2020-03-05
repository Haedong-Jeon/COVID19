//
//  Location.swift
//  COVID19
//
//  Created by 전해동 on 2020/02/28.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate{
    static let location = Location()
    let locationManager = CLLocationManager()
    var positionString:String?
    var CLLocation:CLLocation?
    override private init(){
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentPosition = locations.last else{
            return
        }
        CLLocation = currentPosition
        positionString = "\(currentPosition)"
    }    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

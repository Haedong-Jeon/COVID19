//
//  DeviceConfigure.swift
//  COVID19
//
//  Created by 전해동 on 2020/02/28.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit
import SystemConfiguration
import CoreLocation

class DeviceConfigure: NSObject{
    
    static let instance = DeviceConfigure()

    enum locationServiceStatus{
        case notDetermined
        case deniedOrRestricted
        case authorized
    }
    
    override private init(){
        //NOTHING
    }
    //네트워크
    func deviceIsConnectedToNetwork()->Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue:zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
    //위치 서비스
    func getLocation()->locationServiceStatus{
        let status = CLLocationManager.authorizationStatus()
        switch status{
        case .notDetermined:
            Location.location.locationManager.requestWhenInUseAuthorization()
            return locationServiceStatus.notDetermined
        case .denied, .restricted:
            return locationServiceStatus.deniedOrRestricted
        case .authorizedAlways, .authorizedWhenInUse:
            return locationServiceStatus.authorized
        }
    }        
}

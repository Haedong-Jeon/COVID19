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
    
    override private init(){
        //NOTHING
    }
    //위치 서비스
    func checkLocationService()->Int{
        let locationPermission = CLLocationManager.authorizationStatus()
        switch locationPermission{
            case .denied, .restricted:
                return Alert.TYPE.locationPermissionDenied
            case .notDetermined:
                Location.location.locationManager.requestWhenInUseAuthorization()
                return Alert.TYPE.locationPermissionNotDetermined
            case .authorizedAlways:
                return Alert.TYPE.noAlert
            case .authorizedWhenInUse:
                return Alert.TYPE.noAlert
            @unknown default:
                    return Alert.TYPE.locationPermissionDenied
        }
    }
    //네트워크
    func checkDeviceNetworkStatus()->Int{
        if deviceIsConnectedToNetwork() == false{
            return Alert.TYPE.networkConnectionError
        }else{
            return Alert.TYPE.noAlert
        }
    }
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
}


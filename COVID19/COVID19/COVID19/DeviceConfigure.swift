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
    //네트워크
    func confirmNetworkConnection(){
        if deviceIsConnectedToNetwork() == false{
            print("network connection is bad")
            let alert:UIAlertController = UIAlertController(title: "네트워크 연결 오류", message: "네트워크가 불안정합니다.", preferredStyle: .alert)
            let action:UIAlertAction = UIAlertAction(title:"다시 시도", style: .default, handler: {
                (ACTION) in self.confirmNetworkConnection()
            })
            alert.addAction(action)
            alert.show()
            print("walk through showing message")
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
    //위치 서비스
    func getLocationServicePermission(){
        let permissionStatus = CLLocationManager.authorizationStatus()
        switch permissionStatus{
            case .notDetermined:
                Location.location.locationManager.requestWhenInUseAuthorization()
                return
            case .denied, .restricted:
                let alert:UIAlertController = UIAlertController(title: "위치 서비스", message: "위치 서비스 사용을 허가해주세요.", preferredStyle: .alert)
                let action:UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(action)
                alert.show()
            case .authorizedAlways, .authorizedWhenInUse:
                return
        @unknown default:
            return
        }
    }
}
//경고 메시지 확장
extension UIAlertController {
  func show() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = UIViewController()
    window.windowLevel = UIWindow.Level.alert
    window.makeKeyAndVisible()
    window.rootViewController?.present(self, animated: false, completion: nil)
  }
}

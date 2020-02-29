//
//  FirstSceneViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/02/28.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit

class FirstSceneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkDeviceNetworkStatus()
        checkLocationService()
        performSegue(withIdentifier: "goToSecond", sender: nil)
    }
    //네트워크
    func checkDeviceNetworkStatus(){
        if DeviceConfigure.instance.deviceIsConnectedToNetwork() == false{
            let alert = UIAlertController(title: Constant.networkConnectionErrorTitle, message: Constant.networkConnectionErrorMsg, preferredStyle: .alert)
            let action = UIAlertAction(title: Constant.retry, style: .default, handler: {
                (ACTION) in self.checkDeviceNetworkStatus()
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    //위치 서비스
    func checkLocationService(){
        let locationPermission = DeviceConfigure.instance.getLocationServicePermission()
        switch locationPermission{
            case .authorized:
                return
            case .deniedOrRestricted:
                let alert = UIAlertController(title: Constant.locationPermissionDeniedAlertTitle, message: Constant.locationPermissionDeniedAlertMsg, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: Constant.ok, style: .default, handler: nil)
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
            case .notDetermined:
                Location.location.locationManager.requestWhenInUseAuthorization()
        }
    }
}

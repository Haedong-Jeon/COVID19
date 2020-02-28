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
        checkLocationService()
        checkDeviceNetworkStatus()
    }
    
    func checkDeviceNetworkStatus(){
        if(!DeviceConfigure.instance.deviceIsConnectedToNetwork()){
            let alert:UIAlertController = UIAlertController(title: "네트워크 연결 오류", message: "네트워크가 불안정합니다.", preferredStyle: .alert)
            let action:UIAlertAction = UIAlertAction(title:"다시 시도", style: .default, handler: {
                (ACTION) in self.checkDeviceNetworkStatus()
            })
            alert.addAction(action)
            showAlertMessage(message: alert)
        }
    }
    
    func checkLocationService(){
        let locationServiceStatus = DeviceConfigure.instance.getLocation()
        switch locationServiceStatus{
        case .deniedOrRestricted:
            let alert = UIAlertController(title: "위치 서비스", message: "위치 서비스를 켜주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            showAlertMessage(message: alert)
            return
        case .notDetermined:
            DeviceConfigure.instance.locationManager.requestWhenInUseAuthorization()
            return
        case .authorized:
            break
        }
        DeviceConfigure.instance.locationManager.delegate = DeviceConfigure.instance.self
        DeviceConfigure.instance.locationManager.startUpdatingLocation()
        
    }
    
    func showAlertMessage(message:UIAlertController){
        present(message, animated:true, completion: nil)
    }
}

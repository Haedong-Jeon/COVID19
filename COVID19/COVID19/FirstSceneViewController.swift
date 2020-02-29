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
    //위치 서비스
    func checkLocationService(){
        let locationPermission = DeviceConfigure.instance.getLocationServicePermission()
        switch locationPermission{
            case .authorized:
                return
            case .deniedOrRestricted:
                showAlertMsg(msgTitle: Constant.locationPermissionDeniedAlertTitle, msgBody: Constant.locationPermissionDeniedAlertMsg, btn: Constant.ok)
            case .notDetermined:
                Location.location.locationManager.requestWhenInUseAuthorization()
        }
    }
    //네트워크
    func checkDeviceNetworkStatus(){
        if DeviceConfigure.instance.deviceIsConnectedToNetwork() == false{
            showAlertMsg(msgTitle: Constant.networkConnectionErrorTitle, msgBody: Constant.networkConnectionErrorMsg, btn: Constant.retry){
                (ACTION) in self.checkDeviceNetworkStatus()
            }
        }else{
            goToMenuScreen()
        }
    }
    //메뉴 화면으로 이동
    func goToMenuScreen(){
        performSegue(withIdentifier: "goToSecond", sender: nil)
    }
    //오류 메시지
    func showAlertMsg(msgTitle:String, msgBody:String, btn:String){
        let alert = UIAlertController(title: msgTitle, message: msgBody, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btn, style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    func showAlertMsg(msgTitle:String, msgBody:String, btn:String, handler: @escaping (UIAlertAction)->()){
        let alert = UIAlertController(title: msgTitle, message: msgBody, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btn, style: .default, handler: handler)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

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
    //기기 초기 설정 확인
    override func viewDidAppear(_ animated: Bool) {
        let locationServiceStatus = DeviceConfigure.instance.checkLocationService()
        let networkServiceStatus = DeviceConfigure.instance.checkDeviceNetworkStatus()
        
        if locationServiceStatus == Alert.TYPE.locationPermissionDenied{
            showAlertMsg(msgTitle: Constant.locationPermissionDeniedAlertTitle, msgBody: Constant.locationPermissionDeniedAlertMsg, btn: Constant.ok){
                (ACTION) in self.viewDidAppear(true)
            }
        }
        else if networkServiceStatus == Alert.TYPE.networkConnectionError{
            showAlertMsg(msgTitle: Constant.networkConnectionErrorTitle, msgBody: Constant.networkConnectionErrorMsg, btn: Constant.retry){
                (ACTION) in self.viewDidAppear(true)
            }
        }
        if locationServiceStatus == Alert.TYPE.noAlert && networkServiceStatus == Alert.TYPE.noAlert{
            changeScreen(identifierString: "goToSecond")
        }
    }
    //화면 이동
    func changeScreen(identifierString:String){
        performSegue(withIdentifier: identifierString, sender: nil)
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

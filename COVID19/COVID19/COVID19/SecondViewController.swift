//
//  SecondViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/02/28.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        let locationServiceStatus = DeviceConfigure.instance.checkLocationService()
        let netWorkServiceStatus = DeviceConfigure.instance.checkDeviceNetworkStatus()
        
        if locationServiceStatus == Alert.TYPE.locationPermissionDenied{
            showAlertMsg(msgTitle: Constant.locationPermissionDeniedAlertTitle, msgBody: Constant.locationPermissionDeniedAlertMsg, btn: Constant.ok)
        }
        if netWorkServiceStatus == Alert.TYPE.networkConnectionError{
            showAlertMsg(msgTitle: Constant.networkConnectionErrorTitle, msgBody: Constant.networkConnectionErrorMsg, btn: Constant.retry){
                (ACTION) in self.viewDidAppear(true)
            }
        }
        
    }
    //이 화면은 내렸을 때 앱 종료
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        }
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


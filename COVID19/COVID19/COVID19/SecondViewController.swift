//
//  SecondViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/02/28.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit

class SecondViewController: CustomViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool){
        let locationServiceStatus = DeviceConfigure.instance.checkLocationService()
        let netWorkServiceStatus = DeviceConfigure.instance.checkDeviceNetworkStatus()
        
        if locationServiceStatus == Alert.TYPE.locationPermissionDenied{
            super.showAlertMsg(msgTitle: Constant.locationPermissionDeniedAlertTitle, msgBody: Constant.locationPermissionDeniedAlertMsg, btn: Constant.ok)
        }
        if netWorkServiceStatus == Alert.TYPE.networkConnectionError{
            super.showAlertMsg(msgTitle: Constant.networkConnectionErrorTitle, msgBody: Constant.networkConnectionErrorMsg, btn: Constant.retry){
                (ACTION) in self.viewDidAppear(true)
            }
        }
        
    }
    //메뉴 버튼 클릭시 이동
    @IBAction func goToStatusByRegionScene(){
        performSegue(withIdentifier: "goToStatusByRegion", sender: nil)
    }
    @IBAction func goToOrderMasksScene(){
        performSegue(withIdentifier: "goToOrderMasks", sender: nil)
    }
    @IBAction func goToRelatedNewsScene(){
        performSegue(withIdentifier: "goToRelatedNews", sender: nil)
    }
    @IBAction func goTocheckDangerLocationScene(){
        performSegue(withIdentifier: "goToCheckDangerLocation", sender: nil)
    }
    //이 화면은 내렸을 때 앱 종료
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        if isBeingDismissed{
            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        }
    }
}


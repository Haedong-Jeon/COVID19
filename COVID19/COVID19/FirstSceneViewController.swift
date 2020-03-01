//
//  FirstSceneViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/02/28.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit

class FirstSceneViewController: CustomViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //기기 초기 설정 확인
    override func viewDidAppear(_ animated: Bool) {
        let locationServiceStatus = DeviceConfigure.instance.checkLocationService()
        let networkServiceStatus = DeviceConfigure.instance.checkDeviceNetworkStatus()
        
        if locationServiceStatus == Alert.TYPE.locationPermissionNotDetermined{
            self.viewDidAppear(true)//위치 서비스 동의 변경 사항을 적용하기위해 함수 다시 실행
        }
        else if locationServiceStatus == Alert.TYPE.locationPermissionDenied{
            super.showAlertMsg(msgTitle: Constant.locationPermissionDeniedAlertTitle, msgBody: Constant.locationPermissionDeniedAlertMsg, btn: Constant.ok){
                (ACTION) in self.viewDidAppear(true)
            }
        }
        if networkServiceStatus == Alert.TYPE.networkConnectionError{
            super.showAlertMsg(msgTitle: Constant.networkConnectionErrorTitle, msgBody: Constant.networkConnectionErrorMsg, btn: Constant.retry){
                (ACTION) in self.viewDidAppear(true)
            }
        }
        if locationServiceStatus == Alert.TYPE.noAlert && networkServiceStatus == Alert.TYPE.noAlert{
            super.changeScreen(identifierString: "goToSecond")
        }
    }
}

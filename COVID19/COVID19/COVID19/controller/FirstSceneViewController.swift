//
//  FirstSceneViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/02/28.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift

class FirstSceneViewController: CustomViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //기기 초기 설정 확인
    override func viewDidAppear(_ animated: Bool) {
        let locationServiceStatus = DeviceConfigure.instance.checkLocationService()
        let networkStatus = DeviceConfigure.instance.checkDeviceNetworkStatus()
        
        locationServiceStatus
            .filter{permission in permission == .notDetermined}
            .subscribe(onNext:{_ in self.viewDidAppear(true)})
            .dispose()
        locationServiceStatus
            .skipWhile{permission in permission == .authorizedAlways || permission == .authorizedWhenInUse}
            .subscribe(onNext:{_ in super.showAlertMsg(msgTitle: Constant.locationPermissionDeniedAlertTitle, msgBody: Constant.locationPermissionDeniedAlertMsg, btn: Constant.ok){
                (ACTION) in self.viewDidAppear(true)}})
            .dispose()
        networkStatus
            .filter{status in status == Alert.TYPE.networkConnectionError}
            .subscribe(onNext:{_ in super.showAlertMsg(msgTitle: Constant.networkConnectionErrorTitle, msgBody: Constant.networkConnectionErrorMsg, btn: Constant.ok){
                (ACTION) in self.viewDidAppear(true)}})
            .dispose()
        Observable.combineLatest(locationServiceStatus, networkStatus, resultSelector: {
            (locationServiceStatus:CLAuthorizationStatus, networkStatus:Int) in return (locationServiceStatus, networkStatus)
            })
            .subscribe(onNext:{chk in if chk.0 != .denied && chk.0 != .notDetermined && chk.1 != Alert.TYPE.networkConnectionError{
                super.changeScreen(identifierString: "goToSecond")}})
            .dispose()
    }
}

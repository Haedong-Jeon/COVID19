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
        //performSegue(withIdentifier: "goToSecond", sender: nil)
    }
    
    func checkDeviceNetworkStatus(){
        DeviceConfigure.instance.confirmNetworkConnection()
    }
    
    func checkLocationService(){
        DeviceConfigure.instance.getLocationServicePermission()
    }
}

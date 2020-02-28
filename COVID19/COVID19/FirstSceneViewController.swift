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
    }
    
    func  checkDeviceNetworkStatus(){
        if(DeviceConfigure.instance.deviceIsConnectedToNetwork()){
            let firstViewController = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(identifier: "FirstViewController")
            present(firstViewController, animated: true, completion: nil)
        }else{
            let alert:UIAlertController = UIAlertController(title: "네트워크 연결 오류", message: "네트워크가 불안정합니다.", preferredStyle: .alert)
            let action:UIAlertAction = UIAlertAction(title:"다시 시도", style: .default, handler: {
                (ACTION) in self.checkDeviceNetworkStatus()
            })
            alert.addAction(action)
            present(alert, animated:true, completion: nil)
        }
    }

}

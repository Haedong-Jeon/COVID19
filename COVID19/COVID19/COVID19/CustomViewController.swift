//
//  CustomViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/03/01.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    //화면 이동
    func changeScreen(identifierString:String){
        performSegue(withIdentifier: identifierString, sender: nil)
    }
}

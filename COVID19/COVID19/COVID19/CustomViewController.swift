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
    func showAlertMsg(msgTitle:String?, msgBody:String?, btn:String?){
        let alert = UIAlertController(title: msgTitle, message: msgBody, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btn, style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    func showAlertMsg(msgTitle:String?, msgBody:String?, btn:String?, handler: @escaping (UIAlertAction)->()){
        let alert = UIAlertController(title: msgTitle, message: msgBody, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btn, style: .default, handler: handler)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    func showAlertMsg(msgTitle:String?, msgBody:String?, btn1:String?, btn2:String?, handler1: @escaping (UIAlertAction)->(), handler2: @escaping(UIAlertAction)->()){
        let alert = UIAlertController(title: msgTitle, message: msgBody, preferredStyle: .alert)
        let alertAction1 = UIAlertAction(title: btn1, style: .default, handler: handler1)
        let alertAction2 = UIAlertAction(title: btn2, style: .default, handler: handler2)
        alert.addAction(alertAction1)
        alert.addAction(alertAction2)
        present(alert,animated:true, completion: nil)
    }
    //로딩 화면
    func loadingScreen()->UIActivityIndicatorView{
        var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: view.frame.midX-50, y: view.frame.midY-50, width: 100, height: 100)
        activityIndicator.color = UIColor.blue
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }
    //화면 이동
    func changeScreen(identifierString:String){
        performSegue(withIdentifier: identifierString, sender: nil)
    }
}

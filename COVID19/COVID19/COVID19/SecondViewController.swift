//
//  SecondViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/02/28.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //이 화면은 내렸을 때 앱 종료
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        }
    }
}

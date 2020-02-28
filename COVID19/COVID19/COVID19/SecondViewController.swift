//
//  SecondViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/02/28.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var positionTextLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionTextLabel?.text = Location.location.positionString
        // Do any additional setup after loading the view.
    }
}

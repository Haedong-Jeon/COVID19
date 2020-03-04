//
//  CheckDangerLocationViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/03/01.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit
import CoreLocation

class CheckDangerLocationViewController: CustomViewController {
    @IBOutlet weak var location:UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        location?.text = Location.location.positionString
    }
    
}

//
//  StatusByRegionViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/03/01.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit

class StatusByRegionViewController: CustomViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Region.cities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath) as? regionCell else{
            return UITableViewCell()
        }
        cell.cityName?.text = Region.cities[indexPath.row]
        cell.numOfPatient?.text = "\(444)";
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

class regionCell: UITableViewCell{
    @IBOutlet weak var cityName:UILabel!
    @IBOutlet weak var numOfPatient:UILabel!
}

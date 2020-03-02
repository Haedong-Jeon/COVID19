//
//  StatusByRegionViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/03/01.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit
import Kanna

class StatusByRegionViewController: CustomViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Region.cities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath) as? regionCell else{
            return UITableViewCell()
        }
        cell.cityName?.text = Region.cities[indexPath.row]
        cell.numOfPatient?.text = NumOfPatient.patientNum[indexPath.row]
        cell.numOfPatient?.textColor = UIColor.red
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NumOfPatient.patientNum.removeAll()
        let mainURL = "http://ncov.mohw.go.kr/bdBoardList_Real.do?brdId=1&brdGubun=13&ncvContSeq=&contSeq=&board_id=&gubun="
        guard let main = URL(string: mainURL) else {
          print("Error: \(mainURL) doesn't seem to be a valid URL")
          return
        }
        do{
          let coronaCityMain = try String(contentsOf: main, encoding: .utf8)
          let doc = try HTML(html: coronaCityMain, encoding: .utf8)
          for product in doc.xpath("//div[@class='data_table tbl_scrl_mini2 mgt24']/table/tbody/tr"){
            let productTable = product.nextSibling?.at_xpath("td")?.nextSibling?.text
            NumOfPatient.patientNum.append("\(productTable ?? "defaultErrorString")")
            print(productTable ?? "defaultErrorString")
        }
          
        }catch let error{
          print("Error: \(error)")
        }
    }
}

class regionCell: UITableViewCell{
    @IBOutlet weak var cityName:UILabel!
    @IBOutlet weak var numOfPatient:UILabel!
}

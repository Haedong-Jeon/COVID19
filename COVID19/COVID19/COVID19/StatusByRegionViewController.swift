//
//  StatusByRegionViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/03/01.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit
import Kanna
import RxSwift

class StatusByRegionViewController: CustomViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Region.cities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath) as? regionCell else{
            return UITableViewCell()
        }
        let cityIdx = super.safeArrayIndex(targetIdx: indexPath.row, ArraySize: Region.cities.count)
        let patientNumIdx = super.safeArrayIndex(targetIdx: indexPath.row, ArraySize: NumOfPatient.patientNum.count)
        cell.cityName?.text = Region.cities[cityIdx]
        cell.numOfPatient?.text = NumOfPatient.patientNum[patientNumIdx]
        cell.numOfPatient?.textColor = UIColor.red
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Region.cities.removeAll()
        NumOfPatient.patientNum.removeAll()
        let mainURL = Constant.statusByRegionURL
        guard let main = URL(string: mainURL) else {
          print("Error: \(mainURL) doesn't seem to be a valid")
          return
        }
        do{
          let coronaCityMain = try String(contentsOf: main, encoding: .utf8)
          let doc = try HTML(html: coronaCityMain, encoding: .utf8)
            for htmlSource in doc.xpath(Constant.regionalTable){
            let patientNum = Observable<String?>.just(findPatientNum(source: htmlSource))
            let city = Observable<String?>.just(findCityName(source: htmlSource))
           
            city
                .filter{city in city != nil}
                .subscribe(onNext:{city in Region.cities.append(city!)})
                .dispose()
            patientNum
                .filter{num in num != nil}
                .subscribe(onNext:{num in NumOfPatient.patientNum.append("\(num ?? "-")")})
                .dispose()
        }
        }catch let error{
          print("Error: \(error)")
        }
    }
    func findPatientNum(source:XMLElement)->String?{
        return source.nextSibling?.at_xpath("td")?.nextSibling?.text
    }
    func findCityName(source:XMLElement)->String?{
        return source.nextSibling?.at_xpath("th")?.text
    }
}
class regionCell: UITableViewCell{
    @IBOutlet weak var cityName:UILabel!
    @IBOutlet weak var numOfPatient:UILabel!
}

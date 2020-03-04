//
//  SecondViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/02/28.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit
import Kanna
import RxSwift
import Charts

class SecondViewController: CustomViewController, ChartViewDelegate{
    @IBOutlet weak var chart:PieChartView?
    var counter:Int = 0
    var values:Array<Double> = []
    var dataEntries:Array<ChartDataEntry> = []
    var colors:Array<UIColor> = [UIColor.blue, UIColor.red]
    var labels:Array<String> = ["완치", "사망"]
    var LegendEntries:Array<LegendEntry> = []
    override func viewDidLoad(){
        super.viewDidLoad()
        getDataForPieChart()
        changeStringToDoubleForData()
        controllLegend()
        
        for i in 0 ... mainStatus.mainStatus.count-1{
            let dataEntry =  PieChartDataEntry()
            dataEntry.y = values[i]
            dataEntry.label = labels[i]
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label:"국내 동향")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        chart?.data = pieChartData

        
        chart?.legend.entries = LegendEntries
        pieChartDataSet.colors = self.colors

    }
    override func viewDidAppear(_ animated: Bool){
        
    }
    //메뉴 버튼 클릭시 이동
    @IBAction func goToStatusByRegionScene(){
        performSegue(withIdentifier: "goToStatusByRegion", sender: nil)
    }
    @IBAction func goToOrderMasksScene(){
        performSegue(withIdentifier: "goToOrderMasks", sender: nil)
    }
    @IBAction func goToRelatedNewsScene(){
        performSegue(withIdentifier: "goToRelatedNews", sender: nil)
    }
    @IBAction func goTocheckDangerLocationScene(){
        performSegue(withIdentifier: "goToCheckDangerLocation", sender: nil)
    }
    //이 화면은 내렸을 때 앱 종료
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        if isBeingDismissed{
            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        }
    }
    //파이 차트를 그리기 위한 데이터를 얻기
    func getDataForPieChart(){
        let mainURL = "http://ncov.mohw.go.kr/bdBoardList_Real.do?brdId=1&brdGubun=11&ncvContSeq=&contSeq=&board_id=&gubun="
        guard let main = URL(string: mainURL) else {
          print("Error: \(mainURL) doesn't seem to be a valid URL")
          return
        }
        do{
          let coronaStatus = try String(contentsOf: main, encoding: .utf8)
          let doc = try HTML(html: coronaStatus, encoding: .utf8)
            for htmlSource in doc.xpath(Constant.mainStatusTable){
                if counter >= 3{
                    //불필요한 정보는 처낸다.
                    break
                }
                let test = Observable<String?>.just(htmlSource.text)
                test
                    .filter{text in text != nil}
                    .subscribe(onNext:{text in self.counter += 1; mainStatus.mainStatus.append(text!)})
                    .dispose()
        }
            mainStatus.mainStatus.remove(at: 0)//맨앞 정보는 확진자 수. 너무 많아서 이제 별 의미 없다.
        }catch let error{
          print("Error: \(error)")
        }
    }
    
    func changeStringToDoubleForData(){
        var sum = 0.0
        for i in 0...mainStatus.mainStatus.count-1{
            mainStatus.mainStatus[i] = mainStatus.mainStatus[i].trimmingCharacters(in: ["명"])
            mainStatus.mainStatus[i] = mainStatus.mainStatus[i].components(separatedBy: [","]).joined()
            let value = (mainStatus.mainStatus[i] as NSString).doubleValue
            sum += value
            values.append(value)
            print(values[i])
        }
        for i in 0...values.count-1{
            values[i] = (values[i] / sum) * 100
        }
    }
    func controllLegend(){
        for i in 0 ... labels.count-1{
            let legend = LegendEntry(label: labels[i], form: .default, formSize: .nan, formLineWidth: .nan, formLineDashPhase: .nan, formLineDashLengths: nil, formColor: colors[i])
            LegendEntries.append(legend)
        }
    }
}



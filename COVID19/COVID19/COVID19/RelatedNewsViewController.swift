//
//  RelatedNewsViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/03/01.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit
import Kanna
import RxSwift

class RelatedNewsViewController: CustomViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return News.headline.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? newsCell else{
            return UITableViewCell()
        }
        let newsIdx = super.safeArrayIndex(targetIdx: indexPath.row, ArraySize: News.headline.count)
        cell.headline?.text = News.headline[newsIdx]
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewsDetail"{
            let vc = segue.destination as? NewsDetailViewController
            if let index = sender as? Int{
                vc?.newsURL = News.detailUrl[index]
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNewsDetail", sender: indexPath.row)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        News.headline.removeAll()
        let newsURL = Constant.coronaNewsURL
        guard let main = URL(string: newsURL) else {
          print("Error: \(newsURL) doesn't seem to be a valid URL")
          return
        }
        do{
          let newsHeadline = try String(contentsOf: main, encoding: .utf8)
          let doc = try HTML(html: newsHeadline, encoding: .utf8)
            for htmlSource in doc.xpath(Constant.newsHeadlineTable){
                let newsHead = Observable<String?>.just(htmlSource.text)
                let detailURL = Observable<String?>.just(htmlSource["href"])
                newsHead
                    .filter{newsHeadline in newsHeadline != nil}
                    .subscribe(onNext:{newsHeadline in News.headline.append(newsHeadline!)})
                    .dispose()
                detailURL
                    .filter{url in url != nil}
                    .subscribe(onNext:{url in News.detailUrl.append(url!)})
                    .dispose()
            }
        }catch let error{
          print("Error: \(error)")
        }

    }
}

class newsCell: UITableViewCell{
    @IBOutlet weak var headline:UILabel?
    var newsURL:String = ""
}



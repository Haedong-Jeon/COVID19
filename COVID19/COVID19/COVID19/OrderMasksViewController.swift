//
//  OrderMasksViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/03/01.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit
import WebKit

class OrderMasksViewController:  CustomViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        
    override func loadView() {
        super.loadView()
        webView = WKWebView(frame: self.view.frame)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        self.view = self.webView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myBlog = "https://search.shopping.naver.com/search/all.nhn?origQuery=%EB%A7%88%EC%8A%A4%ED%81%AC&spec=M10018852%7CM10811848%5EM10018852%7CM10811847%5EM10018852%7CM10811849&pagingIndex=1&pagingSize=40&viewType=list&sort=rel&frm=NVSHATT&query=%EB%A7%88%EC%8A%A4%ED%81%AC"
        let url = URL(string: myBlog)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Swift.Void){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let otherAction = UIAlertAction(title: "OK", style: .default, handler: {action in completionHandler()})
        alert.addAction(otherAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Swift.Void){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: {(action) in completionHandler(false)})
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in completionHandler(true)})
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
//        activityIndicator = UIActivityIndicatorView(style: .UIActivityIndicatorView.Style.large)
        activityIndicator.frame = CGRect(x: view.frame.midX-50, y: view.frame.midY-50, width: 100, height: 100)
        activityIndicator.color = UIColor.red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        //activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}

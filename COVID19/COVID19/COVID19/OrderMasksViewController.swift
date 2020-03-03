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
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    override func loadView() {
        super.loadView()
        webView = WKWebView(frame: self.view.frame)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        self.view = self.webView!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let shoppingUrl = Constant.shoppingURL
        let url = URL(string: shoppingUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Swift.Void){
        super.showAlertMsg(msgTitle: nil, msgBody: message, btn: Constant.ok){
            action in completionHandler()
        }
    }
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Swift.Void){
        super.showAlertMsg(msgTitle: nil, msgBody: message, btn1: Constant.cancel, btn2: Constant.ok, handler1: {action in completionHandler(false)}, handler2: {action in completionHandler(true)})
        
    }
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        activityIndicator = super.loadingScreen()
        self.view.addSubview(activityIndicator)
    }
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        self.activityIndicator.removeFromSuperview()
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}

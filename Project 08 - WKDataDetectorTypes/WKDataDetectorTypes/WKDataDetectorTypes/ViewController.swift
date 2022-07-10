//
//  ViewController.swift
//  WKDataDetectorTypes
//
//  Created by jc.kim on 7/8/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    private var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        let configuration = WKWebViewConfiguration()
        configuration.dataDetectorTypes = .all
        webView = WKWebView(frame: view.frame, configuration: configuration)
        view.addSubview(webView)
        
        let url = URL(string: "https://ko.flightaware.com/live/flight/AFR702")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}


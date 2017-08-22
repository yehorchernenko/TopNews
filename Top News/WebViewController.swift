//
//  WebViewController.swift
//  Top News
//
//  Created by Egor on 14.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    var stringUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = stringUrl{
            if let requestUrl = URL(string: url){
            webView.loadRequest(URLRequest(url: requestUrl))
            }
        }
    }
 
    deinit {
        print("web view deinited")
    }
}

//
//  WebViewController.swift
//  Top News
//
//  Created by Egor on 14.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var webView: UIWebView!
    var stringUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.tintColor = UIColor.white

        if let url = stringUrl{
            if let requestUrl = URL(string: url){
            webView.loadRequest(URLRequest(url: requestUrl))
            }
        }
    }

}

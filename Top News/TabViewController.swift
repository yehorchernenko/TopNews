//
//  TabViewController.swift
//  Top News
//
//  Created by Egor on 21.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit
import CoreData

class TabViewController: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        VCType = .tabVC
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchArticleFromDB()
    }
}

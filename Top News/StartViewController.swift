//
//  StartViewController.swift
//  Top News
//
//  Created by Egor on 21.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class StartViewController: MainViewController {

    var refresher: UIRefreshControl!
    
    var sourceOfApi: [ApiObject]?
    var sourceIndex = -1
    var newsAlreadyFetched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Refreshing...")
        refresher.addTarget(self, action: #selector(StartViewController.pullToRefresh), for: .valueChanged)
        tableView.addSubview(refresher)
        
        tableView.infiniteScrollIndicatorMargin = 40
        
        tableView.addInfiniteScroll { [weak self] (tableView) in //problem here
            self?.loadData()
            self?.tableView.finishInfiniteScroll()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        sourceOfApi = SourceOfAPI.sortByState()
        
        if !newsAlreadyFetched{
            loadData()
            newsAlreadyFetched = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Load data from API storage
    
    func loadData(){
        if let sourceArray = sourceOfApi{
            if ((sourceArray.count - 2) >= sourceIndex) && (sourceArray.count != 0){
                sourceIndex += 1
                NewsAPI.getNews(stringUrl: sourceArray[sourceIndex].url) { [weak self] (downloadedNews) in
                    if let news = downloadedNews{
                        
                        (self?.articles == nil) ? self?.articles = news : self?.articles?.append(contentsOf: news)
                        
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    //MARK: - Refresher func
    
    func pullToRefresh(){
        articles?.removeAll()
        sourceIndex = -1
        loadData()
        refresher.endRefreshing()
    }
}

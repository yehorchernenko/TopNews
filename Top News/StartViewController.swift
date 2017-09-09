//
//  StartViewController.swift
//  Top News
//
//  Created by Egor on 21.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll
import CoreData


class StartViewController: MainViewController {

    var refresher: UIRefreshControl!
    
    var sourceOfApi: [ApiObject]?
    var sourceIndex = -1
    var newsAlreadyFetched = false
    var isLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Refreshing...")
        refresher.addTarget(self, action: #selector(StartViewController.pullToRefresh), for: .valueChanged)
        tableView.addSubview(refresher)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sourceOfApi = SourceOfAPI.sortByState()
        
        if (sourceOfApi?.count)! > 0 {
            if !newsAlreadyFetched{
                self.pleaseWait()
                loadData()
                newsAlreadyFetched = true
            }
        } else {
            pushSourceVC()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueIdentifier = segue.identifier{
            switch segueIdentifier {
            case "SourceViewControllerSegue":
                DispatchQueue.global(qos: .default).asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    self.articles?.removeAll()
                    self.tableView.reloadData()
                    self.sourceIndex = -1
                    self.newsAlreadyFetched = false
                })
            default:
                assert(false)
            }
        }
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
                        self?.clearAllNotice()
                        self?.refresher.endRefreshing()
                        self?.isLoading = false
                    }
                }
            } else {
                clearAllNotice()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if (deltaOffset <= 0) && !isLoading{
            isLoading = true
            pleaseWait()
            loadData()
        }
    }
    
    //MARK: - Refresher func
    
    func pullToRefresh(){
        articles?.removeAll()
        sourceIndex = -1
        tableView.reloadData()
        loadData()
    }
    
    //MARK: - Unwind
    
    @IBAction func unwindToStartViewController(segue: UIStoryboardSegue){}
    
    //MARK: - Adding to Data Base
    
    func toReadLaterButton(at row: Int) {
        if let article = articles?[row]{
            updateArticlesDB(with: article)
            self.noticeSuccess("Done", autoClear: true, autoClearTime: 1)
        }
    }
    
    func updateArticlesDB(with article: Article){
        container?.performBackgroundTask{ (context) in
                _ = try? ArticleDB.findOrCreateArticle(with: article, context: context)
            
            try? context.save()
        }
    }
    
    func pushSourceVC(){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SourceCollectionViewController") as? SourceCollectionViewController{
            if let navigation = navigationController{
                navigation.pushViewController(vc, animated: true)
            }
        }
    }
}

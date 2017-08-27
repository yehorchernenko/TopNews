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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchArticleFromDB()
    }
    
    //MARK: - CoreData func
    
    func fetchArticleFromDB(){
        if let context = container?.viewContext{
            context.perform { [weak self] in
                let articleRequest: NSFetchRequest<ArticleDB> = ArticleDB.fetchRequest()
                
                if let tempArticles = try? context.fetch(articleRequest){
                    self?.articles?.removeAll()
                    
                    for art in tempArticles{
                        let newArt = Article(author: art.author!, title: art.title!, description: art.descript!, url: art.url!, urlToImage: art.urlToImage!, publishedAt: art.publishedAt!)
                        self?.articles?.append(newArt)
                    }
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func deleteArticleFromDB(at index: Int){
        let context = container?.viewContext
        let articleRequest: NSFetchRequest<ArticleDB> = ArticleDB.fetchRequest()
        
        do{
            let tempArticles = try context?.fetch(articleRequest)
            
            if let art = tempArticles?[index]{
                context?.delete(art)
                
                try context?.save()
                
                fetchArticleFromDB()
                self.noticeSuccess("Done", autoClear: true, autoClearTime: 1)
            }
        } catch{
            print("\(error)")
        }
    }
    @IBAction func deleteButton(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? MainTableViewCell{
            if let indexPath = tableView.indexPath(for: cell){
                deleteArticleFromDB(at: indexPath.row)
            }
        }
    }
}

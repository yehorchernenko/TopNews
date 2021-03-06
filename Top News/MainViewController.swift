//
//  MainViewController.swift
//  Top News
//
//  Created by Egor on 06.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

enum ViewControllerType {
    case mainVC
    case startVC
    case tabVC
    
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PoPUpDelegate, MainViewCellProtocoll {
    
    //MARK: - Properties
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    var VCType = ViewControllerType.mainVC
    
    
    @IBOutlet weak var tableView: UITableView!
    var visualBlurEffect: UIBlurEffect!
    var visualBlurEffectView: UIVisualEffectView!

    var articles: [Article]? = []
    let identifier = "ArticleOFNewsCellIdentifier"
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocalNotification.scheduleNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBlurView()
    }
    
    //MARK: - Working with tableView cells
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MainTableViewCell", owner: self, options: nil)?.first as! MainTableViewCell
        
        cell.titleLabel.text = self.articles?[indexPath.row].title
        cell.author.text = self.articles?[indexPath.row].author
        cell.publishedAtLabel.text = self.articles?[indexPath.row].publishedAt
        cell.mainImageView.sd_setImage(with: URL(string: self.articles?[indexPath.row].urlToImage ?? "http://itdesignhouse.com/wp-content/themes/TechNews/images/img_not_available.jpg"), placeholderImage: #imageLiteral(resourceName: "default"))
        cell.delegate = self
        
        return cell
    }

    
    //MARK: - WebViewController
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webVC.stringUrl = self.articles?[indexPath.row].url
        
        self.present(webVC, animated: true, completion: nil) 
    }
    
    
    //MARK: - PopupView
    
    func seeDescription(at indexPathRow: Int) {
            showPopUpWithDescription(at: indexPathRow)
    }
    
    @IBOutlet var popUpView: PopUpViewWithDescription!
    
    
    func showPopUpWithDescription(at indexPathRow: Int){
        self.view.addSubview(visualBlurEffectView)
        self.view.addSubview(popUpView)

        popUpView.delegate = self
        visualBlurEffectView.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform.init(scaleX: 5, y: 5))

        popUpView.center = self.tableView.center
        popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popUpView.alpha = 0
        popUpView.descriptionLabel.text = self.articles?[indexPathRow].description ?? "None description"
        UIView.animate(withDuration: 0.4) {
            self.visualBlurEffectView.layer.transform = CATransform3DIdentity
            self.visualBlurEffectView.alpha = 1
            
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    
    func closePopUpWithDescription(){
        UIView.animate(withDuration: 0.3, animations: {
            self.visualBlurEffectView.removeFromSuperview()
            self.visualBlurEffectView.alpha = 0.3
            self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popUpView.alpha = 0
        }) { (succes) in
            self.popUpView.removeFromSuperview()
        }
    }
    
    //MARK: Visual effect view
    
    func setupBlurView(){
        visualBlurEffect = UIBlurEffect(style: .light)
        visualBlurEffectView = UIVisualEffectView(effect: visualBlurEffect)
        visualBlurEffectView.frame = view.bounds
        visualBlurEffectView.alpha = 0.3
    }
    
    //MARK: - MainViewCellProtocoll
    
    //MARK: Adding news to DB
    
    func toReadLaterOrDelete(at row: Int) {
        if VCType == .startVC{
            if let article = articles?[row]{
                updateArticlesDB(with: article)
                self.noticeSuccess("Done", autoClear: true, autoClearTime: 1)
            }
        } else if VCType == .tabVC{
            deleteArticleFromDB(at: row)
        }
    }
    
    func updateArticlesDB(with article: Article){
        container?.performBackgroundTask{ (context) in
            _ = try? ArticleDB.findOrCreateArticle(with: article, context: context)
            
            try? context.save()
        }
    }
    
    //MARK: Delete news from DB
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

}

//MARK: - Delegate


protocol PoPUpDelegate{
    func closePopUpWithDescription()
}

protocol MainViewCellProtocoll{
    func seeDescription(at indexPathRow: Int)
    func toReadLaterOrDelete(at row: Int)
    var VCType:ViewControllerType {get set}
}

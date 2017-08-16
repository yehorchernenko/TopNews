//
//  MainViewController.swift
//  Top News
//
//  Created by Egor on 06.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    
    @IBOutlet weak var infiniteFooterView: InfiniteFooterView!
    @IBOutlet weak var tableView: UITableView!
    var sourceOfApi: [ApiObject]?
    var sourceIndex = 1
    var articles: [Article]? = []
    let identifier = "ArticleOFNewsCellIdentifier"
    
    //MARK: - Main func
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //sourceIndex = UserDefaults.standard.value(forKey: "SourceIndex") as? Int ?? 1
        
        sourceOfApi = SourceOfAPI.sortByState()
        
        if sourceOfApi?.count != 0{
            NewsAPI.getNews(stringUrl: (sourceOfApi?[0].url)!) { [weak self] (downloadedNews) in
                if let news = downloadedNews{
                    
                    if self?.articles == nil{
                        self?.articles = news
                    }
                    
                    self?.articles?.append(contentsOf: news)
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: - Working with tableView cells
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! MainTableViewCell
        cell.titleLabel.text = self.articles?[indexPath.row].title
        cell.author.text = self.articles?[indexPath.row].author
        cell.publishedAtLabel.text = self.articles?[indexPath.row].publishedAt
        cell.mainImageView.sd_setImage(with: URL(string: self.articles?[indexPath.row].urlToImage ?? "http://itdesignhouse.com/wp-content/themes/TechNews/images/img_not_available.jpg"), placeholderImage: #imageLiteral(resourceName: "default"))
        cell.mainImageView.frame.size = setSize(image: cell.mainImageView.image!)
        //print(cell.mainImageView.frame.size)
        
        return cell
    }

    //MARK: - Functions
    
    func setSize(image: UIImage) -> CGSize{
        let width = self.tableView.frame.size.width
        let height = image.size.height / image.scale
        
        return CGSize(width: width, height: height)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: - Infinite scrolling methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffest = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if (maximumOffset - currentOffest) <= 0{
            loadMore()
        }
    }
    
    func loadMore(){
        if let sourceArray = sourceOfApi{
            print(sourceArray.count - 1)
            if (sourceArray.count - 1) >= sourceIndex{


                NewsAPI.getNews(stringUrl: sourceArray[sourceIndex].url) { [weak self] (downloadedNews) in
                    if let news = downloadedNews{
                        
                        if self?.articles == nil{
                            self?.articles = news
                        }
                    
                        self?.articles?.append(contentsOf: news)
                        self?.tableView.reloadData()
                        
                        self?.sourceIndex += 1
                        //UserDefaults.standard.set(self?.sourceIndex, forKey: "SourceIndex")
                    }
                }
            }
        }
    }
    
    //MARK: - Web methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webVC.stringUrl = self.articles?[indexPath.row].url
        
        self.present(webVC, animated: true, completion: nil) 
    }
    
    
    //MARK: - PopupView
    
    @IBAction func seeDescriptionButton(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? MainTableViewCell {
            let indexPath = self.tableView.indexPath(for: cell)
            
            showPopUpWithDescription(at: indexPath!)
        }
    }
    
    @IBAction func hideButton(_ sender: UIButton) {
        closePopUpWithDescription()
    }
    @IBOutlet var popUpView: PopUpViewWithDescription!
    
    
    func showPopUpWithDescription(at indexPath: IndexPath){
        self.view.addSubview(popUpView)
        popUpView.center = self.tableView.center
        popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popUpView.alpha = 0
        popUpView.descriptionLabel.text = self.articles?[indexPath.row].description ?? "None description"
        
        UIView.animate(withDuration: 0.4) {
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    
    func closePopUpWithDescription(){
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popUpView.alpha = 0
        }) { (succes) in
            self.popUpView.removeFromSuperview()
        }
    }
}


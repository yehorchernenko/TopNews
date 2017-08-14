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
    
    @IBOutlet weak var tableView: UITableView!
    let stringURL = "https://newsapi.org/v1/articles?source=techcrunch&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af"
    var articles: [Article]? = []
    var choosenSources: [(url: String,image: UIImage,state: Bool)] = []
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
        //choosenSources = SourceOfAPI.sortByState()
        fetchArticles()

    }
    
    //MARK: - Working with tableView cells
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! MainTableViewCell
        cell.titleLabel.text = self.articles?[indexPath.row].title
        cell.author.text = self.articles?[indexPath.row].author
        cell.descriptionLabel.text = self.articles?[indexPath.row].description
        cell.publishedAtLabel.text = self.articles?[indexPath.row].publishedAt
        cell.mainImageView.sd_setImage(with: URL(string: self.articles?[indexPath.row].urlToImage ?? "http://itdesignhouse.com/wp-content/themes/TechNews/images/img_not_available.jpg"), placeholderImage: #imageLiteral(resourceName: "default"))
        
        
        return cell
    }

    //MARK: - Functions
    
    func fetchArticles(){
        if let url = URL(string: stringURL){
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if let taskError = error{
                    print(taskError.localizedDescription)
                    return
                }
                
                
                if let downloadedData = data{
                    if let json = (try? JSONSerialization.jsonObject(with: downloadedData, options: [])) as? [String: Any]{
                        if let articlesFromJson = json["articles"] as? [[String:Any]]{
                            for art in articlesFromJson{
                                guard let author = art["author"] as? String,
                                    let title = art["title"] as? String,
                                    let description = art["description"] as? String,
                                    let url = art["url"] as? String,
                                    let urlToImage = art["urlToImage"] as? String,
                                    let publishedAt = art["publishedAt"] as? String
                                    else {return}
                                
                                let newArticle = Article(author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt)
                                //print("New title is - \(newArticle.title)/b")
                                DispatchQueue.main.async {
                                    self.articles?.append(newArticle)
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            })
            task.resume()
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

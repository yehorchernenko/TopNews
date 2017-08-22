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

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    @IBOutlet weak var tableView: UITableView!


    var articles: [Article]? = []
    let identifier = "ArticleOFNewsCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: - Working with tableView cells
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MainTableViewCell
        cell.titleLabel.text = self.articles?[indexPath.row].title
        cell.author.text = self.articles?[indexPath.row].author
        cell.publishedAtLabel.text = self.articles?[indexPath.row].publishedAt
        cell.mainImageView.sd_setImage(with: URL(string: self.articles?[indexPath.row].urlToImage ?? "http://itdesignhouse.com/wp-content/themes/TechNews/images/img_not_available.jpg"), placeholderImage: #imageLiteral(resourceName: "default"))
        
        return cell
    }

    
    //MARK: - WebViewController
    
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
            //self.visualEffectView.effect = self.effect
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    
    func closePopUpWithDescription(){
        UIView.animate(withDuration: 0.3, animations: {
            //self.visualEffectView.effect = nil
            self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popUpView.alpha = 0
        }) { (succes) in
            self.popUpView.removeFromSuperview()
        }
    }
    

}


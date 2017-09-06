//
//  NewsAPI.swift
//  Top News
//
//  Created by Egor on 06.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class NewsAPI{
    
    //static let sharedInstance = NewsAPI()
    
    class func getNews(stringUrl: String, newsArray: @escaping ([Article]?) -> Void){
        Alamofire.request(stringUrl).responseJSON { (fetchedJson) in
            if let jsonData = fetchedJson.data{
                
                let json = JSON(data: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers  , error: nil)
                
                if let articlesJsonArray = json["articles"].array{
                    for artJson in articlesJsonArray{
                        let newArticle = Article(json: artJson)
                        
                        DispatchQueue.main.async {
                            newsArray([newArticle])
                        }
                    }
                }
            }
        }
    }
    
}

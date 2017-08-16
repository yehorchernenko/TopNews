//
//  NewsAPI.swift
//  Top News
//
//  Created by Egor on 06.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation

class NewsAPI{
    
    class func getNews(stringUrl: String, newsArray: @escaping ([Article]?) -> Void){
        if let url = URL(string: stringUrl){
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //error handling
                if let taskError = error {
                    print("\(taskError.localizedDescription)")
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
                                
                                DispatchQueue.main.async {
                                    newsArray([newArticle])
                                }
                            }
                            
                        }
                    }
                }
            })
            task.resume()
        }
    }
}

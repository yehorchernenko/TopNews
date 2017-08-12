//
//  NewsAPI.swift
//  Top News
//
//  Created by Egor on 06.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation

class NewsAPI{
    private static let baseURL = SourceOfAPI.APIStorage[0].url
    
    class func getNews(complition: @escaping ([Article]?) -> Void){
        
        if let url = URL(string: baseURL){
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let someError = error{
                    print("\(someError.localizedDescription)")
                    return
                }
                
                var news: [Article] = []
                
                if let downloadedData = data{
                    if let json = (try? JSONSerialization.jsonObject(with: downloadedData, options: [])) as? [[String:Any]]{
                        for jsonNews in json {
                            if let downloadedNews = Article.getNewsFrom(JSON: jsonNews){
                                news.append(downloadedNews)
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    complition(news.count > 0 ? news : nil)
                }
            }).resume()
        }
    }
}

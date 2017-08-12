//
//  Article.swift
//  Top News
//
//  Created by Egor on 06.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import UIKit

class Article{
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    
    init(author: String, title: String, description: String, url: String, urlToImage: String, publishedAt: String) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt 
    }
    
    class func getNewsFrom(JSON: [String:Any]) -> Article?{
        guard let articles = JSON["articles"] as? [String:Any] else {return nil}
        
        guard let author = articles["author"] as? String,
            let title = articles["title"] as? String,
            let description = articles["description"] as? String,
            let url = articles["url"] as? String,
            let urlToImage = articles["urlToImage"] as? String,
            let publishedAt = articles["publishedAt"] as? String
            else {return nil}
        
        return Article(author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt)
    }
}

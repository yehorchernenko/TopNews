//
//  Article.swift
//  Top News
//
//  Created by Egor on 06.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

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
    
    init(json: JSON) {

        self.author = json["author"].string ?? "Unknown"
        self.title = json["title"].stringValue
        self.description = json["description"].string ?? "Non description"
        self.url = json["url"].stringValue
        self.urlToImage = json["urlToImage"].stringValue
        self.publishedAt = json["publishedAt"].string ?? "unknown"
    }

}

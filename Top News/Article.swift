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
    let author: String?
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL
    let publishedAt: String?
    
    init(author: String?, title: String, description: String, url: URL, urlToImage: URL, publishedAt: String?) {
        self.author = author ?? "Unknown"
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt ?? "Unknown"
    }
    
    
}

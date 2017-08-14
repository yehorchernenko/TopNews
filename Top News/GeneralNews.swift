//
//  GeneralNews.swift
//  Top News
//
//  Created by Egor on 13.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation

class GeneralNews:Article{
    let source: String
    
    init(author: String, title: String, description: String, url: String, urlToImage: String, publishedAt: String,source: String) {
        self.source = source
        super.init(author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt)
    }
}

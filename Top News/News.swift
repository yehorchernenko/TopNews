//
//  News.swift
//  Top News
//
//  Created by Egor on 06.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import UIKit

class News{
    let status: String
    let source: String
    let sortBy: String
    let articles: [Article]
    
    init(status: String,source: String, sortBy: String, articles: [Article]) {
        self.status = status
        self.source = source
        self.sortBy = sortBy
        self.articles = articles
    }
}

//
//  Source of API.swift
//  Top News
//
//  Created by Egor on 08.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import UIKit

class SourceOfAPI{
    
    //MARK: - All news api
    static var APIStorage:[(url: String,image: UIImage,state: Bool)] =  [("https://newsapi.org/v1/articles?source=ars-technica&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af",#imageLiteral(resourceName: "ars-technica"),false),
    ("https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", #imageLiteral(resourceName: "bbc-news"),false),
    ("https://newsapi.org/v1/articles?source=bild&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af",#imageLiteral(resourceName: "bild"),false ),
    ("https://newsapi.org/v1/articles?source=bbc-sport&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af",#imageLiteral(resourceName: "bbc-sport"),false),
    ("https://newsapi.org/v1/articles?source=bloomberg&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", #imageLiteral(resourceName: "bloomberg"),false),
    ("https://newsapi.org/v1/articles?source=breitbart-news&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", #imageLiteral(resourceName: "breitbart"),false),
    ("https://newsapi.org/v1/articles?source=business-insider&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", #imageLiteral(resourceName: "business-insider"),false)
]
 
}


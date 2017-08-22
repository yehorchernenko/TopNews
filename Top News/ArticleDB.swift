//
//  ArticleDB.swift
//  Top News
//
//  Created by Egor on 22.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import CoreData

class ArticleDB: NSManagedObject{
    class func findOrCreateArticle(with article: Article, context: NSManagedObjectContext) throws -> ArticleDB{
        
        let request: NSFetchRequest<ArticleDB> = ArticleDB.fetchRequest()
        request.predicate = NSPredicate(format: "url = %d", article.url)
        
        do{
            let matches = try context.fetch(request)
            
            if matches.count > 0{
                return matches.first!
            }
        } catch {
            throw error
        }
        
        let articleDB = ArticleDB(context: context)
        articleDB.author = article.author
        articleDB.title = article.title
        articleDB.descript = article.description
        articleDB.publishedAt = article.publishedAt
        articleDB.url = article.url
        articleDB.urlToImage = article.urlToImage
        
        return articleDB
    }
}

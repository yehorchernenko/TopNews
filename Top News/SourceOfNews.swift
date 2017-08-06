//
//  SourceOfNews.swift
//  Top News
//
//  Created by Egor on 06.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import UIKit

class SourceOfNews{
    let title: String
    let image: UIImage
    let url: URL
    let state: Bool
    
    init(title: String, image: UIImage, url: URL, state: Bool) {
        self.title = title
        self.image = image
        self.url = url
        self.state = state
    }
}

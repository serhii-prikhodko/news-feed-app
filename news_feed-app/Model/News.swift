//
//  News.swift
//  news_feed-app
//
//  Created by Serhiy Prikhodko on 3/1/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation

struct News: Codable {
    var title: String?
    var description: String?
    var urlToImage: String?
    var url: String?
}

struct NewsList: Codable {
    var articles: [News]
}

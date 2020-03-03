//
//  NetworkService.swift
//  news_feed-app
//
//  Created by Serhiy Prikhodko on 3/1/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation

class NetworkService {
    static var API_KEY = "0e246b48d2634fd2be285b8773822aef"
    static var COUNTRY = "ua"
    
    static func fetchNews(completion: @escaping (NewsList?, Error?)-> Void) {
        let baseURL = URL(string: "http://newsapi.org/v2/top-headlines")!
        let query: [String: String] = [
            "country": self.COUNTRY,
            "apiKey": self.API_KEY
        ]
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let articles = try jsonDecoder.decode(NewsList.self, from: data)
                    completion(articles, nil)
                    
                } catch let error as NSError {
                    print("ERROR: \(error.localizedDescription)")
                    completion(nil, error)
                }
            } else {
               completion(nil, nil)
            }
        }
        
        task.resume()
    }
    static func fetchNewsImage(news: News, completionHandler: @escaping (_ data: Data?) -> () ) {
        if let url = URL(string: news.urlToImage ?? "") {
        let session = URLSession.shared
            
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("ERROR: \(error!.localizedDescription)")
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
        dataTask.resume()
        }
    }
}
extension URL {
    //Creates ULR, adding params queries to him
    func withQueries(_ queries: [String: String])-> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

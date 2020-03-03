//
//  FeedTableViewController.swift
//  news_feed-app
//
//  Created by Serhiy Prikhodko on 3/1/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
    
    var newsList = [News]()
    var filteredNews = [News]()
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load news from network
        self.loadNewsFeed()
        self.title = "Top Ukraine News"
        self.prepareSearchController()
    }
    
    // MARK: - Functions
    func prepareSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search News"
        navigationItem.searchController = self.searchController
        definesPresentationContext = true
    }
    func filterContentForSearchText(_ searchText: String) {
        self.filteredNews = [News]()
        for news in self.newsList {
            if let title = news.title {
                if title.lowercased().contains(searchText.lowercased()) {
                    self.filteredNews.append(news)
                }
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltering {
            
            return self.filteredNews.count
        }
        
        return self.newsList.count
    }
    func loadNewsFeed() {
        NetworkService.fetchNews() { (news: NewsList?, error: Error?) in
            if let news = news {
                DispatchQueue.main.async {
                    self.newsList = news.articles
                    self.tableView.reloadData()
                }
            } else {
                print ("- fetch eror - \(#function) )")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! SingleNewsTableViewCell
        
        if self.isFiltering {
            cell.update(with: self.filteredNews[indexPath.row])
        } else {
            cell.update(with: self.newsList[indexPath.row])
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "webPageID") as! WebPageViewController
        //Transfer data to next view controller
        if self.isFiltering {
            newViewController.url = (self.filteredNews[indexPath.row].url)
        } else {
            newViewController.url = (self.newsList[indexPath.row].url)
        }

        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
}
extension FeedTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        self.filterContentForSearchText(searchBar.text!)
    }
}

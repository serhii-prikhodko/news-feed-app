//
//  WebPageViewController.swift
//  news_feed-app
//
//  Created by Serhiy Prikhodko on 3/3/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {
    
    var url: String?

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = self.url {
            self.title = url
            self.loadPage(url)
        }
    }
    func loadPage(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

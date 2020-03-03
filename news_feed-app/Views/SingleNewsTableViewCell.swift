//
//  SingleNewsTableViewCell.swift
//  news_feed-app
//
//  Created by Serhiy Prikhodko on 3/1/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class SingleNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsUIImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func update(with news: News?) {
        self.newsUIImageView.image = UIImage(named: "no_image_placeholder")
        if let news = news {
            self.newsTitleLabel.text = news.title
            self.newsDescriptionLabel.text = news.description
            NetworkService.fetchNewsImage(news: news, completionHandler: {(data: Data?) in
                if let data = data {
                    DispatchQueue.main.async { [weak self] in
                        self?.newsUIImageView.image = UIImage(data: data)
                    }
                }
            })
        }
    }
    
}

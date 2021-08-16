//
//  PodcastTableViewCell.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/20/21.
//

import UIKit

class PodcastTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var podcastImage: UIImageView!
    
    var item: RSSItem! {
        
        didSet {
            
            titleLabel.text = item.title
            podcastImage.image = UIImage(named: "BeInPrayerLogo")
            podcastImage.maskCircle(anyImage: podcastImage.image!)
        }
    }

}

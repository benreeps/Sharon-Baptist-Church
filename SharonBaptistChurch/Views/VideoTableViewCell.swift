//
//  VideoTableViewCell.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 2/19/21.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var video:Video?
    
    func setCell(_ v:Video) {
        
        self.video = v
        
        guard self.video != nil else {return}
        
        self.titleLabel.text = video?.title
        
        // Format the video.date into a string
        updateVideoDateFormat(date: video!.published)
        
        // Set the thumbnail
        guard self.video!.thumbnail != "" else {return}
        
        // Check cache before downloading data
        if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail) {
            
            self.thumbnailImageView.image = UIImage(data: cachedData)
        }
        
        // Download thumbnial data
        let url = URL(string: self.video!.thumbnail)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                // Save the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                if url!.absoluteString != self.video?.thumbnail {
                    return
                }
                
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
                
            }
        }
        dataTask.resume()
    }
    
    func updateVideoDateFormat(date: Date) {
        self.dateLabel.text = DateManager.videoDateFormatter.string(from: date)
    }
    
}

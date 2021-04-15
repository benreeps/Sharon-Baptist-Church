//
//  LiveVideoTableViewCell.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 3/23/21.
//

import UIKit

class LiveVideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var liveVideo:LiveVideo?
    
    func setCell(_ v:LiveVideo) {
        
        self.liveVideo = v
        
        guard self.liveVideo != nil else {return}
        
        self.titleLabel.text = liveVideo?.title
        
        thumbnailImageView.layer.cornerRadius = 13.00
        
        // Format the video.date into a string
        updateVideoDateFormat(date: liveVideo!.published)
        
        // Set the thumbnail
        guard self.liveVideo!.thumbnail != "" else {return}
        
        // Check cache before downloading data
        if let cachedData = CacheManager.getVideoCache(self.liveVideo!.thumbnail) {
            
            self.thumbnailImageView.image = UIImage(data: cachedData)
        }
        
        // Download thumbnial data
        let url = URL(string: self.liveVideo!.thumbnail)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                // Save the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                if url!.absoluteString != self.liveVideo?.thumbnail {
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

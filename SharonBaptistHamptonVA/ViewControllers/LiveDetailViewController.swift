//
//  LiveDetailViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 3/23/21.
//

import UIKit
import youtube_ios_player_helper

class LiveDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var liveVideoPlayerView: YTPlayerView!
    
    
    var liveVideo: LiveVideo?

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Clear the field
        titleLabel.text = ""
        dateLabel.text = ""
        
        // Check if there is a video
        guard liveVideo != nil else {return}
        
        // Create the embed url
        let embedUrlString = Constants.YT_EMBED_URL + liveVideo!.videoId
        
        self.liveVideoPlayerView.loadVideo(byURL: embedUrlString, startSeconds: 0)
        
        // Set the title
        titleLabel.text = liveVideo!.title
        
        // Set the date
        updateVideoDateFormat(date: liveVideo!.published)
        
        // Set the description
        self.liveVideoPlayerView.load(withVideoId: liveVideo!.videoId)
    }
    

    func updateVideoDateFormat(date: Date) {
        self.dateLabel.text = DateManager.videoDateFormatter.string(from: date)
    }
}

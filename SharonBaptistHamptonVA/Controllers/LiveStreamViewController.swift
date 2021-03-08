//
//  LiveStreamViewController.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 3/4/21.
//

import UIKit
import youtube_ios_player_helper

class LiveStreamViewController: UIViewController {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var liveVideoPlayerView: YTPlayerView!
    
    var liveVideo: LiveVideo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.liveVideoPlayerView.load(withVideoId: "Ap89DSOItNU")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Clear the field
        titleLabel.text = ""
        dateLabel.text = ""
        
        // Check if there is a video
        guard liveVideo != nil else {return}
        
        let embedUrlString = Constants.YT_EMBED_URL + liveVideo!.videoId
        
        // Load it into the playerView
        let url = URL(string: embedUrlString)
        let request = URLRequest(url: url!)
        
        // Set the title
        titleLabel.text = liveVideo!.title
        
        // Set the date
        updateVideoDateFormat(date: liveVideo!.published)
        
    }
    
    func updateVideoDateFormat(date: Date) {
        self.dateLabel.text = DateManager.videoDateFormatter.string(from: date)
    }
}

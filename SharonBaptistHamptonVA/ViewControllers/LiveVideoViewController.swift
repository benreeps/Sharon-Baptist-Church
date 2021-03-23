//
//  LiveStreamViewController.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 3/4/21.
//

import UIKit
import youtube_ios_player_helper

class LiveVideoViewController: UIViewController, LiveVideoControllerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var liveVideoPlayerView: YTPlayerView!
    
    
    let liveVideoController = LiveVideoController()
    var liveVideos = [LiveVideo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        liveVideoController.delegate = self
        
     //   liveVideoController.getLiveVideos()
        
    }
    
    //MARK:- Model Delegate Methods
    
    func liveVideosFetched(_ liveVideos: [LiveVideo]) {
        DispatchQueue.main.async {
            
            self.liveVideos = liveVideos
            
        }
    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        
        // Clear the field
        titleLabel.text = ""
        dateLabel.text = ""
        
        // Check if there is a video
        guard liveVideos != nil else {return}

        
        // Set the title
        titleLabel.text = liveVideo!.title
        
        // Set the date
        updateVideoDateFormat(date: liveVideo!.published)
        
        // Set the video
        if liveVideo!.lifeCycleStatus == "upcoming" {
            print(liveVideo!.videoId)
            self.liveVideoPlayerView.load(withVideoId: liveVideo!.videoId)
            
        } else {return}
    }
    */
    func updateVideoDateFormat(date: Date) {
        self.dateLabel.text = DateManager.videoDateFormatter.string(from: date)
    }
}


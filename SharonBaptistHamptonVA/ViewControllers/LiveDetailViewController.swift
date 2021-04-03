//
//  LiveDetailViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 3/23/21.
//

import UIKit
import youtube_ios_player_helper

class LiveDetailViewController: UIViewController {
    
    @IBOutlet weak var liveVideoPlayerView: YTPlayerView!
    
    
    var liveVideo: LiveVideo?

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        
        // Check if there is a video
        guard liveVideo != nil else {return}
        
        // Create the embed url
       // let embedUrlString = Constants.YT_EMBED_URL + liveVideo!.videoId
        
        self.liveVideoPlayerView.load(withPlaylistId: liveVideo!.videoId)
       // self.liveVideoPlayerView.loadVideo(byURL: embedUrlString, startSeconds: 0)
        
    }

}

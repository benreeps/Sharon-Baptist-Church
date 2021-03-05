//
//  LiveStreamViewController.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 3/4/21.
//

import UIKit
import youtube_ios_player_helper

class LiveStreamViewController: UIViewController {
    
    @IBOutlet weak var liveVideoPlayerView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.liveVideoPlayerView.load(withVideoId: "Ap89DSOItNU")
        
    }
    
}

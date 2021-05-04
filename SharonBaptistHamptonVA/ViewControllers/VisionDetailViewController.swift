//
//  VisionDetailViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/19/21.
//

import UIKit
import youtube_ios_player_helper

class VisionDetailViewController: UIViewController {

    @IBOutlet weak var youtubePlayerView: YTPlayerView!
    
    var videoId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.youtubePlayerView.load(withVideoId: self.videoId)
        }   
    }
}

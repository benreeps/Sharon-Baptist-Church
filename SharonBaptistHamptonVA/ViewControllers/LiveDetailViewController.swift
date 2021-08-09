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
    @IBOutlet weak var shareButton: UIButton!
    
    let currentUrlString = Constants.VIDEO_ID_URL
    var currentUrl: String = " "
    var liveVideo: LiveVideo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Check if there is a video
        guard liveVideo != nil else {return}
        
        self.liveVideoPlayerView.load(withVideoId: liveVideo!.videoId)
        // self.liveVideoPlayerView.loadVideo(byURL: embedUrlString, startSeconds: 0)
        currentUrl = currentUrlString + liveVideo!.videoId
    }
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        
        if currentUrl != " "{
            
            let items: [Any] = [URL(string: "\(currentUrl)")!]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(ac, animated: true)
        } else {
            return
        }
    }
}

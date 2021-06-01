//
//  DetailViewController.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 2/23/21.
//

import UIKit
import WebKit
import youtube_ios_player_helper

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var youtubePlayerView: YTPlayerView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    
    let currentUrlString = Constants.VIDEO_ID_URL
    var currentUrl: String = " "
    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Clear the field
        titleLabel.text = ""
        textView.text = "" 
        
        // Check if there is a video
        guard video != nil else {return}
        print("\(video!.videoId)")
        youtubePlayerView.load(withVideoId: video!.videoId)
        
        // Set the title
        titleLabel.text = video!.title
        
        // Set the description
        textView.text = video!.description
        currentUrl = currentUrlString + video!.videoId
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

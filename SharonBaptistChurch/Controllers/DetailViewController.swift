//
//  DetailViewController.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 2/23/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var textView: UITextView!
    
    var video:Video?

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Clear the field
        titleLabel.text = ""
        dateLabel.text = ""
        textView.text = "" 
        
        // Check if there is a video
        guard video != nil else {return}
        
        // Create the embed url
        let embedUrlString = Constants.YT_EMBED_URL + video!.videoId
        
        // Load it into the webview
        let url = URL(string: embedUrlString)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        // Set the title
        titleLabel.text = video!.title
        
        // Set the date
        updateVideoDateFormat(date: video!.published)
        
        // Set the description
        textView.text = video!.description
    }
    

    func updateVideoDateFormat(date: Date) {
        self.dateLabel.text = DateManager.videoDateFormatter.string(from: date)
    }
}

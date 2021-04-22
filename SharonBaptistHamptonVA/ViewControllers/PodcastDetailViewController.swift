//
//  PodcastDetailViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/21/21.
//

import UIKit
import AVFoundation

class PodcastDetailViewController: UIViewController {
    
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var reverseBackground: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var playPauseBackground: UIView!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var forwardBackground: UIView!
    @IBOutlet weak var podcastImageView: UIImageView!
    
    
    var rssItem: RSSItem!
    var player: AVAudioPlayer?
    
    
    var isPlaying = false {
        didSet {
            if isPlaying  {
                playPauseButton.setImage(UIImage(named: "pause")!, for: .normal)
                player?.play()
            } else {
                playPauseButton.setImage(UIImage(named: "play")!, for: .normal)
                player?.pause()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = rssItem!.audioUrl
        let url = NSURL(string: urlString)
        
        downloadFileFromURL(url: url!)
        
        reverseBackground.layer.cornerRadius = 35.0
        reverseBackground.clipsToBounds = true
        reverseBackground.alpha = 0.0
        
        playPauseBackground.layer.cornerRadius = 35.0
        playPauseBackground.clipsToBounds = true
        playPauseBackground.alpha = 0.0
        
        forwardBackground.layer.cornerRadius = 35.0
        forwardBackground.clipsToBounds = true
        forwardBackground.alpha = 0.0
        
    }
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        
        
        if isPlaying {
            UIView.animate(withDuration: 0.5) {
                self.podcastImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.podcastImageView.transform = CGAffineTransform.identity
            })
        }
        
        isPlaying = !isPlaying
    }
    @IBAction func touchedUpInside(_ sender: UIButton) {
        let buttonBackground: UIView
        
        switch sender {
        
        case reverseButton:
            buttonBackground = reverseBackground
        case playPauseButton:
            buttonBackground = playPauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            buttonBackground.alpha = 0.0
            buttonBackground.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            sender.transform = CGAffineTransform.identity
        }) { (_) in buttonBackground.transform = CGAffineTransform.identity}
    }
    @IBAction func touchedDown(_ sender: UIButton) {
        let buttonBackground: UIView
        
        switch sender {
        
        case reverseButton:
            buttonBackground = reverseBackground
        case playPauseButton:
            buttonBackground = playPauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        
        UIView.animate(withDuration: 0.25) {
            buttonBackground.alpha = 0.3
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        
    }
    
    
    
    
    
    
    func downloadFileFromURL(url:NSURL) {
        var downloadTask: URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url as URL, completionHandler: {[weak self](URL, response, error) -> Void in self?.prepare(url: URL! as NSURL)
            
            if self!.isPlaying {
                self!.player?.play()
            }
        })
        
        downloadTask.resume()
    }
    
    func prepare(url:NSURL) {
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url as URL)
            player?.prepareToPlay()
            player?.volume = 2.0
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
    
}


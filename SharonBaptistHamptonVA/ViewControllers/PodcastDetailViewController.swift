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
    @IBOutlet weak var podcastTitleLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLable: UILabel!
    
    
    var rssItem: RSSItem!
    var rssItems: [RSSItem]?
    var player: AVAudioPlayer?
    var timer:Timer?
    
    
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
        guard let url = NSURL(string: urlString) else {
            return
        }
        
        downloadFileFromURL(url: url)
        
        reverseBackground.layer.cornerRadius = 35.0
        reverseBackground.clipsToBounds = true
        reverseBackground.alpha = 0.0
        
        playPauseBackground.layer.cornerRadius = 35.0
        playPauseBackground.clipsToBounds = true
        playPauseBackground.alpha = 0.0
        
        forwardBackground.layer.cornerRadius = 35.0
        forwardBackground.clipsToBounds = true
        forwardBackground.alpha = 0.0
        
        podcastImageView.layer.shadowColor = UIColor.black.cgColor
        podcastImageView.layer.shadowOpacity = 1
        podcastImageView.layer.shadowOffset = CGSize.zero
        podcastImageView.layer.shadowRadius = 10
       
        podcastTitleLabel.text = rssItem.title
      
        
        player?.pause()
        timeSlider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        timeSlider.minimumValue = 00.00
        
        timeSlider.value = 0
      
        startTimeLabel.text = "00:00"
        endTimeLable.text = "00:00"
        
        
       
      
    }

    
    
    @IBAction func forwardButtonPressed(_ sender: Any) {
        
        //let position = rssItems?[indexPathForSelectedRow!.row]
        
    }
    
    @IBAction func timeSliderValueChanged(_ sender: Any) {
        let currentTimeSliderValue = timeSlider.value
        player?.pause()
        
        if isPlaying == true {
            player?.currentTime = TimeInterval(currentTimeSliderValue)
            
            if let currentTime = player?.currentTime {
                startTimeLabel.text = "\(translateToHourMinSec(time: Float(currentTime)))"
            }
            
            player?.play()
        } else {
            
            player?.currentTime = TimeInterval(currentTimeSliderValue)
            
            if let currentTime = player?.currentTime {
                startTimeLabel.text = "\(translateToHourMinSec(time: Float(currentTime)))"
                
            }
            
            player?.pause()
            
        }
        
        
        
        
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
        
        if player?.isPlaying != nil {
            
        }
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
            
            DispatchQueue.main.async {
                self!.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self!, selector: #selector(self!.changeSliderValueToCurrentTime), userInfo: nil, repeats: true)
                self!.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self!, selector: #selector(self!.changeStartEndTimeToCurrentTimeDuration), userInfo: nil, repeats: true)
                
                self!.timeSlider.maximumValue = Float(self!.player!.duration)
                
            }
            
            if self!.isPlaying {
                
                self!.player?.play()
                
            }
        })
        
        downloadTask.resume()
    }
    
    @objc func changeSliderValueToCurrentTime() {
       
        let currentTimeFloat = Float(player!.currentTime)
       
            timeSlider.value = currentTimeFloat
        
    }
    
    @objc func changeStartEndTimeToCurrentTimeDuration() {
        
        let currentTime = player!.currentTime
        let duration = player!.duration
        
        
        startTimeLabel.text = "\(translateToHourMinSec(time: Float(currentTime)))"
        endTimeLable.text = "\(translateToHourMinSec(time: Float(duration)))"
        
    
    }
    
    func translateToHourMinSec (time: Float) -> String  {
        let allTime: Int = Int(time)
        var hours = 0
        var minutes = 0
        var seconds = 0
        var hoursText = ""
        var minutesText = ""
        var secondsText = ""
        
        hours = allTime / 3600
        hoursText = hours > 9 ? "\(hours)": ""
        
        minutes = allTime % 3600 / 60
        minutesText = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        seconds = allTime % 3600 % 60
        secondsText = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        if hours <= 0 {
            return "\(minutesText):\(secondsText)"
        } else {
            return "\(hoursText):\(minutesText):\(secondsText)"
        }
       
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

    
    

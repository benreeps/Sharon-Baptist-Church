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
    var allRssItems: [RSSItem]? = []
    var position: Int = 0
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
        configure()
        
    }
    
    
    @IBAction func reverseButtonPressed(_ sender: Any) {
        if position > 0 {
            position = position - 1
            player?.stop()
            configure()
        }
    }
    @IBAction func forwardButtonPressed(_ sender: Any) {
        if position < allRssItems!.count - 1 {
            position = position + 1
            player?.stop()
            configure()
        }
        
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
        
    }
    @IBAction func touchedUpInside(_ sender: UIButton) {
        let buttonBackground: UIView
        
        switch sender {
        
        case reverseButton:
            DispatchQueue.main.async {
                self.timeSlider.value = 0
                self.startTimeLabel.text = "00:00"
            }
            buttonBackground = reverseBackground
            
        case playPauseButton:
            buttonBackground = playPauseBackground
            
        case forwardButton:
            
            buttonBackground = forwardBackground
            DispatchQueue.main.async {
                self.timeSlider.value = 0
                self.startTimeLabel.text = "00:00"
            }
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
                // self!.player!.play(atTime: TimeInterval(0))
                //self!.player!.pause()
                self?.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self!, selector: #selector(self!.changeSliderValueToCurrentTime), userInfo: nil, repeats: true)
                self?.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self!, selector: #selector(self!.changeStartEndTimeToCurrentTimeDuration), userInfo: nil, repeats: true)
                self?.timeSlider.maximumValue = Float(self!.player!.duration)
                
            }
            
            if (self?.isPlaying == false) {
                
                self!.player?.pause()
                
            } else {
                self?.player?.play()
            }
        })
        
        downloadTask.resume()
    }
    
    func configure() {
        
        let rssItem = allRssItems![position]
        let urlString = rssItem.audioUrl
        
        DispatchQueue.main.async {
            guard let url = NSURL(string: urlString) else {
                return
            }
            do {
                self.timeSlider.value = 0
                self.endTimeLable.text = "00:00"
                self.startTimeLabel.text = "00:00"
                self.downloadFileFromURL(url: url)
            }
            
            self.reverseBackground.layer.cornerRadius = 35.0
            self.reverseBackground.clipsToBounds = true
            self.reverseBackground.alpha = 0.0
            
            self.playPauseBackground.layer.cornerRadius = 35.0
            self.playPauseBackground.clipsToBounds = true
            self.playPauseBackground.alpha = 0.0
            
            self.forwardBackground.layer.cornerRadius = 35.0
            self.forwardBackground.clipsToBounds = true
            self.forwardBackground.alpha = 0.0
            
            self.podcastImageView.layer.shadowColor = UIColor.black.cgColor
            self.podcastImageView.layer.shadowOpacity = 1
            self.podcastImageView.layer.shadowOffset = CGSize.zero
            self.podcastImageView.layer.shadowRadius = 10
            
            self.podcastTitleLabel.text = rssItem.title
            
            //player?.pause()
            self.timeSlider.setThumbImage(UIImage(named: "thumb"), for: .normal)
            self.timeSlider.minimumValue = 00.00
            
            UIView.animate(withDuration: 0.5) {
                self.podcastImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
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




//
//  HomeViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 3/26/21.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var ourTeamView: UIView!
    @IBOutlet weak var ourVisionButton: UIButton!
    @IBOutlet weak var podcastButton: UIButton!
    @IBOutlet weak var contactUsButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var spotifyButton: UIButton!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ourVisionButton.layer.cornerRadius = 9
        setTitleViewImage()
    }
    
    @IBAction func contactUsButtonPressed(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.sharonbaptisthamptonva.com/contact-us.html") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler:nil)
        }
    }
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
        
        if let url = NSURL(string: "https://www.facebook.com/pages/category/Religious-Organization/Sharon-Baptist-Church-1418020258440404/") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler:nil)
        }
    }
    @IBAction func spotifyButtonPressed(_ sender: UIButton) {
        
        if let url = NSURL(string: "https://open.spotify.com/show/166LgDxMlYssjDw2NKqL9V") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler:nil)
        }
    }
    @IBAction func youtubeButtonPressed(_ sender: UIButton) {
        
        if let url = NSURL(string: "https://www.youtube.com/channel/UCCAX6g8NjHQILMegQcuHJdA/featured") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler:nil)
        }
    }
    @IBAction func emailButtonPressed(_ sender: UIButton) {
        
        if let url = NSURL(string: "https://www.sharonbaptisthamptonva.com/contact-us.html") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler:nil)
        }
    }
    
    func setTitleViewImage() {
        
        let image: UIImage = UIImage(named: "sharon cropped png3")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(-5.0, for: .default)
    }
   
    @IBAction func unwind(_ seg: UIStoryboardSegue) {
        
    }
}



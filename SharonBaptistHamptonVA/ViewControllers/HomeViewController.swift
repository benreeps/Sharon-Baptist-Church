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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ourVisionButton.layer.cornerRadius = 9
        setTitleViewImage()
    }
    
    @IBAction func ourVisionButtonPressed(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.sharonbaptisthamptonva.com/vision.html") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler:nil)
        }
    }
    
    @IBAction func podcastButtonPressed(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.sharonbaptisthamptonva.com/podcasts.html") {
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
    
    
}



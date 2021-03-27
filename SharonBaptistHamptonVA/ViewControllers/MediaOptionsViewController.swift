//
//  MediaOptionsViewController.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 3/1/21.
//

import UIKit

class MediaOptionsViewController: UIViewController {
    
    @IBOutlet weak var allSermonsButton: UIButton!
    @IBOutlet weak var liveSermonButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func allSermonsButtonPressed(_ sender: UIButton) {
      
        sender.pulsate()
    }
    @IBAction func liveSermonButtonPressed(_ sender: UIButton) {
        
        sender.pulsate()
    }
    
}

//
//  MediaOptionsViewController.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 3/1/21.
//

import UIKit

class MediaOptionsViewController: UIViewController {
    
    @IBOutlet weak var allSermonsView: UIView!
    @IBOutlet weak var allSermonsButton: UIButton!
    @IBOutlet weak var liveSermonButton: UIButton!
    @IBOutlet weak var liveSermonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allSermonsView.layer.cornerRadius = 10
        liveSermonView.layer.cornerRadius = 10
        allSermonsButton.layer.cornerRadius = 10
        allSermonsButton.layer.cornerRadius = 10
    }
}

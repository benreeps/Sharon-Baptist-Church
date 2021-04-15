//
//  OurLeadersDetailViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/9/21.
//

import UIKit

class OurLeadersDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    
    var leader: Leader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = leader.spouseImage
        nameLabel.text = leader.leaderSpouseName
        titleLabel.text = leader.title
        textView.text = leader.description
    }
}

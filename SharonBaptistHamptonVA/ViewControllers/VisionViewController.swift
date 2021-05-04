//
//  VisionViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/19/21.
//

import UIKit

class VisionViewController: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    let video1Id = "xLrfhsGOOyQ"
    let video2Id = "pjaN1YWxVn8"

    override func viewDidLoad() {
        super.viewDidLoad()

        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Confirm that a video was selected
        guard let visionDetailVC = segue.destination as? VisionDetailViewController else {
            return
        }
        
        if (segue.identifier == "video1") {
            
            // Set the video property of the detail view controller
            visionDetailVC.videoId = video1Id
            
        } else if (segue.identifier == "video2") {
            visionDetailVC.videoId = video2Id
            
        }
    }
}
    
  



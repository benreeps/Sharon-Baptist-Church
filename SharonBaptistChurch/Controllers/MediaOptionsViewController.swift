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

        allSermonsButton.layer.cornerRadius = 15.0
        liveSermonButton.layer.cornerRadius = 15.0 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
